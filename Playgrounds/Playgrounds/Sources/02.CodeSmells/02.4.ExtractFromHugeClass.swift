//
//  02.4.ExtractFromHugeClass.swift
//  Playgrounds
//
//  Created by 한현민 on 6/7/25.
//

import Foundation

public enum PaymentMethod {
    case card
    case samsungPay
    case accountTransfer
}

public protocol Payment {
    // 저장 속성
    var amount: Int { get }
    
    // 연산 속성
    var isPaymentSuccessful: Bool { get }
    
    // 구현 필요 메서드
    func pay()
    
    // 기본 구현 메서드
    func validateFingerprintData() -> Bool
    func validateCreditCardNumber() -> Bool
}

public extension Payment {
    func validateFingerprintData() -> Bool { true }
    func validateCreditCardNumber() -> Bool { true }
}

public final class Card: Payment {
    public var amount: Int
    private var creditCardNumber: String
    
    public var isPaymentSuccessful: Bool {
        true
    }
    
    init(amount: Int, creditCardNumber: String) {
        self.amount = amount
        self.creditCardNumber = creditCardNumber
    }
    
    public func pay() {
        
    }
}

public final class SamsungPay: Payment {
    public var amount: Int
    private var creditCardNumber: String
    private var fingerprintData: String
    
    public var isPaymentSuccessful: Bool {
        validateFingerprintData() && validateCreditCardNumber()
    }
    
    init(amount: Int, creditCardNumber: String, fingerprintData: String) {
        self.amount = amount
        self.creditCardNumber = creditCardNumber
        self.fingerprintData = fingerprintData
    }
    
    public func pay() {
        
    }
}

public final class AccountTransfer: Payment {
    public var amount: Int
    private var accountNumber: String?
    private var targetAccountNumber: String?
    
    public var isPaymentSuccessful: Bool {
        true
    }
    
    init(amount: Int, accountNumber: String? = nil, targetAccountNumber: String? = nil) {
        self.amount = amount
        self.accountNumber = accountNumber
        self.targetAccountNumber = targetAccountNumber
    }
    
    public func pay() {
        
    }
}
