//
//  FactoryMethod.swift
//  MyPlaygrounds
//
//  Created by 한현민 on 6/15/25.
//

import Foundation

enum FactoryMethod: Example {
    protocol Vehicle {
        func deliver()
    }
    
    struct MotorCycle: Vehicle {
        func deliver() {
            print("Delivering a MotorCycle")
        }
    }
    
    struct Car: Vehicle {
        func deliver() {
            print("Delivering a Car")
        }
    }
    
    protocol AbstractFactory {
        func createProduct() -> Vehicle
    }
    
    final class MotorCycleFactory: AbstractFactory {
        func createProduct() -> Vehicle {
            return MotorCycle()
        }
    }
    
    final class BicycleFactory: AbstractFactory {
        func createProduct() -> Vehicle {
            return Car()
        }
    }
    
    static func run() {
        let motorCycleFactory = MotorCycleFactory()
        let vehicle: Vehicle = motorCycleFactory.createProduct()
        vehicle.deliver()
        
        let bicycleFactory = BicycleFactory()
        let bicycle: Vehicle = bicycleFactory.createProduct()
        bicycle.deliver()
    }
}
