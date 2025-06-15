//
//  02.2.ExtractMethods.swift
//  Playgrounds
//
//  Created by 한현민 on 6/7/25.
//

import Foundation

public enum TransferError: String, Error {
    case invalidTransmitter = "invalid transmitter"
    case sendError = "send error"
}

public protocol Sender {
    var receiver: String { get }
    var text: String { get }
    
    // 구현이 필요한 메서드
    func check(transmitter: String) -> Bool

    // 기본 구현 메서드
    func prepareSending()
    func send(transmitter: String) throws (TransferError)
}

public extension Sender {
    func prepareSending() {}
    
    func send(transmitter: String) throws (TransferError) {
        guard check(transmitter: transmitter) else {
            throw .invalidTransmitter
        }
        
        prepareSending()
        
        throw .sendError
//        print("Send Success: \(receiver) -> \(text)")
    }
}

public final class SMS: Sender {
    public private(set) var receiver: String
    public private(set) var text: String
    
    init(receiver: String, text: String) {
        self.receiver = receiver
        self.text = text
    }
    
    public func check(transmitter: String) -> Bool {
        return false
    }
    
    public func prepareSending() {
        print(#function, "preparing to send SMS ...")
    }
}

public final class Email: Sender {
    public private(set) var receiver: String
    public private(set) var text: String
    
    init(receiver: String, text: String) {
        self.receiver = receiver
        self.text = text
    }
    
    public func check(transmitter: String) -> Bool {
        return true
    }
    
    public func prepareSending() {
        print(#function, "preparing to send Email ...")
    }
}

public final class RemoveDuplicateCode {
    public static func sendSMS(phoneNumber: String, text: String) {
        let sender = SMS(receiver: phoneNumber, text: text)
        
        do {
            try sender.send(transmitter: "010-1234-5678")
        } catch {
            print(error)
        }
    }
    
    public static func sendEmail(email: String, text: String) {
        let sender = Email(receiver: email, text: text)
        
        do {
            try sender.send(transmitter: "sender@example.com")
        } catch {
            print(error)
        }
    }
}
