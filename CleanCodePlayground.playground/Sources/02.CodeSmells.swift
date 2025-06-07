import Foundation

// nonisolated <-> actor 간 데이터 전달을 위한 Sendable 프로토콜 채택
public enum MenuType: Sendable {
    case pizza
    case coffee
}

// nonisolated <-> actor 간 데이터 전달을 위한 Sendable 프로토콜 채택
public struct Menu: Sendable, Equatable {
    // Equatable 준수를 위해 UUID 속성 추가 및 인스턴스 간 동일 비교 기준을 UUID로 설정
    public static func == (lhs: Menu, rhs: Menu) -> Bool {
        lhs.uuid == rhs.uuid
    }

    var uuid = UUID()
    
    public let type: MenuType
    public let name: String
    public let amount: Int
    
    public private(set) var soldAmount = 0
    
    // 외부에서 soldAmount 1 증가 연산을 요청하기 위한 mutating 메서드
    public mutating func incrementSoldAmount() {
        self.soldAmount += 1
    }
}

// Race Condition 해결을 위해서 final class -> actor 변경
public actor SaleSystem {
    public static let shared = SaleSystem()
    
    public private(set) var pizzaList = [Menu]()
    public private(set) var coffeeList = [Menu]()
    
    private init() {
        Task {
            await self.initMenu()
        }
    }
    
    public func initMenu() {
        self.pizzaList = [
            .init(type: .pizza, name: "pizza", amount: 10),
            .init(type: .pizza, name: "pizza1", amount: 10),
            .init(type: .pizza, name: "pizza2", amount: 10),
            .init(type: .pizza, name: "pizza3", amount: 10),
            .init(type: .pizza, name: "pizza4", amount: 10),
        ]
        
        self.coffeeList = [
            .init(type: .coffee, name: "Americano", amount: 10),
            .init(type: .coffee, name: "Cafe Latte", amount: 10),
            .init(type: .coffee, name: "Cafe Mocca", amount: 10),
            .init(type: .coffee, name: "Capuccino", amount: 10),
            .init(type: .coffee, name: "Caramel Machiato", amount: 10),
        ]
    }
    
    public func incrementSoldAmount(menu: Menu) {
        switch menu.type {
        case .pizza:
            guard var updated = pizzaList.first(where: { $0 == menu }) else {
                return
            }
            updated.incrementSoldAmount()
            
        case .coffee:
            guard var updated = coffeeList.first(where: { $0 == menu }) else {
                return
            }
            updated.incrementSoldAmount()
        }
    }
}

public final class Store: Sendable {
    public init() {}
    
    public func printSellPizzaMenu(saleSystem: SaleSystem) async {
        let pizzaList = await saleSystem.pizzaList
        print(#function, pizzaList)
        
        for pizza in pizzaList {
            print(pizza.name, ":", pizza.soldAmount)
            await saleSystem.incrementSoldAmount(menu: pizza)
            print(pizza.name, ":", pizza.soldAmount)
        }
    }
    
    public func printSellCoffeeMenu(saleSystem: SaleSystem) async {
        let coffeeList = await saleSystem.coffeeList
        print(#function, coffeeList)
        
        for coffee in coffeeList {
            print(coffee.name, ":", coffee.soldAmount)
            await saleSystem.incrementSoldAmount(menu: coffee)
            print(coffee.name, ":", coffee.soldAmount)
        }
    }
}
