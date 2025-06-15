//
//  Decorator.swift
//  MyPlaygrounds
//
//  Created by 한현민 on 6/15/25.
//

import Foundation
import Playgrounds

protocol Coffee {
    func getDescription() -> String
}

struct BaseCoffee: Coffee {
    func getDescription() -> String {
        "Coffee"
    }
}

struct MilkCoffee: Coffee {
    let base: Coffee
    
    func getDescription() -> String {
        base.getDescription() + " with Milk"
    }
}

struct CaramelMachiato: Coffee {
    // 생성자를 통한 인스턴스 주입
    let base: Coffee
    
    // 주입한 인스턴스의 메서드와 기본 메서드를 가지고 처리
    func getDescription() -> String {
        base.getDescription() + " with Caramel and Machiato"
    }
}

#Playground {
    let coffee1: Coffee = BaseCoffee()
    let coffee2: Coffee = MilkCoffee(base: BaseCoffee())
    let coffee3: Coffee = CaramelMachiato(base: BaseCoffee())
    let coffee4: Coffee = CaramelMachiato(base: MilkCoffee(base: BaseCoffee()))
    
    coffee1.getDescription()
    coffee2.getDescription()
    coffee3.getDescription()
    coffee4.getDescription()
}
