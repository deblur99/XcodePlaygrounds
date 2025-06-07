//
//  PlaygroundsTests.swift
//  PlaygroundsTests
//
//  Created by 한현민 on 6/7/25.
//

import Testing
@testable import Playgrounds

struct PlaygroundsTests {
    @Test func test_01_1() {
        // 1) 기존 생성자 호출 방식
        let jua: Person = .init(name: "김주아", age: 9, gender: .female, weight: 20.0, height: 130.0, isMarried: false)

        // 2) 정적 팩토리 메서드 방식
        let someMan: Person = .manWithAge(name: "Hynn", age: 27)

        // 3) 빌더 패턴 방식
        let wisue: PersonWithBuilder = PersonWithBuilder.Builder()
            .setName("김위수")
            .setAge(30)
            .setGender(.female)
            .setWeight(50)  // 임의로 넣은 수치
            .setHeight(165) // 임의로 넣은 수치
            .setIsMarried(false)
            .build()
        
        print("wisue: \(wisue)")
        
        #expect(true)
    }

    @Test func test_01_2() {
        let vpcManager = VPCManager()
        
        // 1) 처리 성공 여부를 Bool로 표현하는 방식
        if (!vpcManager.deleteVPCResourceUsingBool()) {
            print("deleteVPCResourceUsingBool(): Some VPCs cannot be deleted.")
        }
        
        // 2) 처리 중 예외 발생 여부를 Typed Error 방식으로 표현하는 방식
        do {
            try vpcManager.deleteVPCResourceUsingException()
        } catch {
            print("deleteVPCResourceUsingException():", error.rawValue)
        }
        
        #expect(true)
    }

    // MARK: 02. Code Smells

    @Test func test_02_1() async {
        let store = Store(saleSystem: SaleSystem())
        await store.printSellCoffeeMenu()
        await store.printSellPizzaMenu()
        
        #expect(true)
    }
    
    @Test func test_02_2() async {
        RemoveDuplicateCode.sendSMS(phoneNumber: "010-1111-2222", text: "Hello World!")
        RemoveDuplicateCode.sendEmail(email: "example@icloud.com", text: "Hello World!")
        
        #expect(true)
    }
    
    @Test func test_02_3() async {
        _ = ExtractMethods()
        
        #expect(true)
    }
    

    @Test func test_integrated() async throws {
        await test_02_2()
        
        #expect(true)
    }
}
