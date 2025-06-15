//
//  Strategy.swift
//  MyPlaygrounds
//
//  Created by 한현민 on 6/15/25.
//

import Foundation
import Playgrounds

protocol Payment {
    func pay(amount: Int)
}

struct CreditCard: Payment {
    func pay(amount: Int) {
        print("CreditCard: \(amount)")
    }
}

struct SamsungPay: Payment {
    func pay(amount: Int) {
        print("SamsungPay: \(amount)")
    }
}

struct KakaoPay: Payment {
    func pay(amount: Int) {
        print("KakaoPay: \(amount)")
    }
}

actor DeliveryApp {
    internal private(set) var payment: Payment
    
    init(payment: Payment) {
        self.payment = payment
    }
    
    func setPayment(_ payment: Payment) async {
        self.payment = payment
    }
    
    func pay(_ amount: Int) async {
        payment.pay(amount: amount)
    }
}

#Playground {
    let deliveryApp = DeliveryApp(payment: CreditCard())
    
    Task {
        await deliveryApp.pay(10000)
    }
}
