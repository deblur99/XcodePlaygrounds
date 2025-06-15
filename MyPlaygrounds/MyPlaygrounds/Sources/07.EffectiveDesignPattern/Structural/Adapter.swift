//
//  Adapter.swift
//  MyPlaygrounds
//
//  Created by 한현민 on 6/15/25.
//

import Foundation

/// Target: 새로 연결하고자 하는 인터페이스
protocol Target {
    func doSomething(number: Int)
}

/// Adaptee: 원래 사용하던 클래스
open class Adaptee {
    func doSomething(message: String) {
        print(message)
    }
}

/// 클래스 어댑터: Adaptee를 상속하고 Target을 구현
/// ```java
/// final class ClassAdapter extends Adaptee implements Target
/// ```
final class ClassAdapter: Adaptee, Target {
    /// 상속을 하면 ClassAdapter의 doSomething과 Adaptee의 doSomething을 외부에서 둘 다 접근 가능
    /// - 메서드 시그니처가 모호해지는 문제가 생긴다.
    /// - 그래서 클래스 어댑터 방식보다 객체 어댑터 방식이 더 선호되는 것 같다.
    func doSomething(number: Int) {
        doSomething(message: "\(number)")
    }
}

/// 객체 어댑터: Adaptee를 인스턴스 속성으로 가지고 Target을 구현
/// ```java
/// final class ObjectAdapter implements Target
/// ```
final class ObjectAdapter: Target {
    private let adaptee: Adaptee
    
    init(adaptee: Adaptee) {
        self.adaptee = adaptee
    }
    
    // 객체 어댑터는 Target의 메서드를 구현해서 그 안에 Adaptee의 메서드를 호출하는 방식으로 처리한다.
    func doSomething(number: Int) {
        adaptee.doSomething(message: "\(number)")
    }
}
