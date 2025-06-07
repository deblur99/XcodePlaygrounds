import Foundation

// nonisolated <-> actor 간 데이터 전달을 위한 Sendable 프로토콜 채택
public enum MenuType: Sendable {
    case pizza
    case coffee
}

// nonisolated <-> actor 간 데이터 전달을 위한 Sendable 프로토콜 채택
public struct Menu: Sendable, Equatable, Hashable {
    // UUID를 Menu의 구분자로 사용
    public static func == (lhs: Menu, rhs: Menu) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    // UUID를 딕셔너리 키로 사용
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    var uuid = UUID()
    public let type: MenuType
    public let name: String
    public let amount: Int
    
    // Menu 구조체 내부에서 변경하지 않고, 해당 구조체의 인스턴스 상태를 관리하는 actor에서 직접 상태를 변경하는 쪽으로 작성해야 한다.
}

// Race Condition 해결을 위해서 final class -> actor 변경
public actor SaleSystem {
    public private(set) var pizzaList: [Menu]
    public private(set) var coffeeList: [Menu]
    
    // pizzaList와 coffeeList의 soldAmount 속성을 actor 내부의 딕셔너리 형태로 관리
    // -> 기존 Menu 내부의 soldAmount 저장 속성을 제거
    
    // * struct 내부에서 상태를 변경하는 것은 추천되지 않음
    // -> 가급적 let으로 내부 속성을 선언하고, 변경될 수 있는 부분들은 해당 인스턴스를 갖는 별도의 actor 내부에서 관리하는 것을 추천함
    private var soldAmountMap = [UUID: Int]()
    
    public init() {
        self.pizzaList = []
        self.coffeeList = []
        
        Task {
            await self.initMenu()
        }
    }
    
    public func initMenu() {
        let pizzas = [Menu](repeating: .init(type: .pizza, name: "pizza", amount: 10), count: 10)
        let coffees = [Menu](repeating: .init(type: .coffee, name: "Americano", amount: 10), count: 10)
        
        self.pizzaList = pizzas
        self.coffeeList = coffees
        
        for menu in pizzas + coffees {
            self.soldAmountMap[menu.uuid] = 0
        }
    }
    
    public func getSoldAmount(menu: Menu) -> Int? {
        guard let soldAmount = soldAmountMap[menu.uuid] else {
            print(#function, "not found")
            return nil
        }
        
        return soldAmount
    }
    
    public func incrementSoldAmount(menu: Menu) {
        switch menu.type {
        case .pizza:
            if let pizza = pizzaList.first(where: { $0 == menu }),
               let _ = soldAmountMap[pizza.uuid]
            {
                soldAmountMap[pizza.uuid]! += 1
            }
            
            
        case .coffee:
            if let coffee = coffeeList.first(where: { $0 == menu }),
               let _ = soldAmountMap[coffee.uuid]
            {
                soldAmountMap[coffee.uuid]! += 1
            }
        }
    }
}

public final class Store: Sendable {
    let saleSystem: SaleSystem
    
    // 의존성 주입 방식으로 처음부터 인스턴스 초기화
    public init(saleSystem: SaleSystem) {
        self.saleSystem = saleSystem
    }
    
    // Store에서는 어떤 작업을 처리할 때마다 주입받은 SaleSystem에 요청 보냄
    public func printSellPizzaMenu() async {
        let pizzaList = await saleSystem.pizzaList
        
        var soldAmount = 0
        for pizza in pizzaList {
            await saleSystem.incrementSoldAmount(menu: pizza)
        }
    }
    
    public func printSellCoffeeMenu() async {
        let coffeeList = await saleSystem.coffeeList
        
        var soldAmount = 0
        for coffee in coffeeList {
            await saleSystem.incrementSoldAmount(menu: coffee)
        }
    }
}
