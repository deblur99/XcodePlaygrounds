//
//  AbstractFactory.swift
//  MyPlaygrounds
//
//  Created by 한현민 on 6/15/25.
//

import Foundation

enum AbstractFactory: Example {
    static func run() {
        let factoryA: AbstractComputer = ComputerA()
        let factoryB: AbstractComputer = ComputerB()
    }
}

extension AbstractFactory {
    protocol AbstractComputer {
        func createMouse() -> Mouse
        func createKeyboard() -> Keyboard
        func createMonitor() -> Monitor
    }
    
    final class ComputerA: AbstractComputer {
        init() {
            print("creates ComputerA")
            _ = createMouse()
            _ = createKeyboard()
            _ = createMonitor()
            print("ComputerA created")
        }
        
        func createMouse() -> Mouse {
            return MouseA()
        }
        
        func createKeyboard() -> Keyboard {
            return KeyboardA()
        }
        
        func createMonitor() -> Monitor {
            return MonitorA()
        }
    }
    
    final class ComputerB: AbstractComputer {
        init() {
            print("creates ComputerB")
            _ = createMouse()
            _ = createKeyboard()
            _ = createMonitor()
            print("ComputerB created")
        }
        
        func createMouse() -> Mouse {
            return MouseB()
        }
        
        func createKeyboard() -> Keyboard {
            return KeyboardB()
        }
        
        func createMonitor() -> Monitor {
            return MonitorB()
        }
    }
}

extension AbstractFactory {
    protocol Mouse {
        
    }
    
    struct MouseA: Mouse {
        init() {
            print("MouseA initialized")
        }
    }
    
    struct MouseB: Mouse {
        init() {
            print("MouseB initialized")
        }
    }
}

extension AbstractFactory {
    protocol Keyboard {
        
    }
    
    struct KeyboardA: Keyboard {
        init() {
            print("KeyboardA initialized")
        }
    }
    
    struct KeyboardB: Keyboard {
        init() {
            print("KeyboardB initialized")
        }
    }
}

extension AbstractFactory {
    protocol Monitor {
        
    }
    
    struct MonitorA: Monitor {
        init() {
            print("MonitorA initialized")
        }
    }
    
    struct MonitorB: Monitor {
        init() {
            print("MonitorB initialized")
        }
    }
}
