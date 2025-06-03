//
//  01.CleanCode.swift
//  
//
//  Created by 한현민 on 6/3/25.
//

import UIKit

public enum Gender: String {
    case male = "M"
    case female = "F"
    case others = "O"
}

public struct Person {
    public let name: String
    public let age: Int
    public let gender: Gender
    public let weight: Double
    public let height: Double
    public let isMarried: Bool
    
    // Swift에서는 기본 생성자 매개변수로 각 매개변수마다 이름을 지정할 수 있고, 호출 시 해당 이름에 맞는 값을 전달해야 한다.
    // - 물론, 매개변수 이름 앞에 타입 외부에서 사용할 이름을 별개로 지정하여 외부에서 사용할 매개변수 이름과 내부에서 사용할 매개변수 이름을 따로 사용하는 것도 가능하다.
    public init(name: String, age: Int, gender: Gender, weight: Double, height: Double, isMarried: Bool) {
        self.name = name
        self.age = age
        self.gender = gender
        self.weight = weight
        self.height = height
        self.isMarried = isMarried
    }
    
    // 비추천) 생성자가 너무 많으면 익명 매개변수 기준으로 어떤 게 어떤 항목인지 한번에 확인하기 어렵다.
    // - C/C++, Java, Javascript 등 옛날부터 있었던 언어들은 이처럼 매개변수를 익명으로 사용하도록 되어 있다.
    public init(_ name: String, _ age: Int, _ gender: Gender, _ weight: Double, _ height: Double, _ isMarried: Bool) {
        self.name = name
        self.age = age
        self.gender = gender
        self.weight = weight
        self.height = height
        self.isMarried = isMarried
    }
    
    // 대안 1: 정적 팩토리 메서드
    // - 더 적은 수의 매개변수를 받아 인스턴스를 생성하고 반환하는 정적 메서드를 사용한다.
    public static func manWithAge(name: String, age: Int) -> Person {
        Person(name: name, age: age, gender: .male, weight: 0.0, height: 0.0, isMarried: false)
    }
}

// 대안 2: 빌더 패턴 사용하기
// - 기존 생성자를 private으로 놓아 외부에서 사용하지 않게 하고, 그 대신 타입에서 제공하는 Builder 인스턴스를 외부에서 사용하고, 해당 인스턴스 메서드를 통해 원래의 인스턴스를 생성하도록 하는 패턴
// - 외부에서 하나씩 setter 메서드를 호출하여 필요한 속성을 생성할 인스턴스에 미리 지정하고, 마지막에 build() 메서드를 호출하여 생성하고자 하는 타입의 인스턴스를 생성
// - Swift에서는 잘 사용되지 않는 방식 (자세한 건 Resources/01.CleanCode.md 참조)
public struct PersonWithBuilder {
    public var name: String?
    public var age: Int?
    public var gender: Gender?
    public var weight: Double?
    public var height: Double?
    public var isMarried: Bool?
    
    private init(name: String?, age: Int?, gender: Gender?, weight: Double?, height: Double?, isMarried: Bool?) {
        self.name = name
        self.age = age
        self.gender = gender
        self.weight = weight
        self.height = height
        self.isMarried = isMarried
    }
    
    public struct Builder {
        private var name: String?
        private var age: Int?
        private var gender: Gender?
        private var weight: Double?
        private var height: Double?
        private var isMarried: Bool?
        
        public init() {}
        
        // 설정하고자 하는 속성에 대한 setter 메서드를 호출하고, 매개변수로 전달된 값을 Builder 인스턴스에 임시 저장한다.
        // - 이때 기존의 설정값을 유지하고, 메서드 체이닝을 사용하기 위해 인스턴스 자기 자신을 반환하는 것이 중요하다.
        public func setName(_ name: String?) -> Self {
            var copy = self
            copy.self.name = name
            return copy
        }
        
        public func setAge(_ age: Int?) -> Self {
            var copy = self
            copy.self.age = age
            return copy
        }
        
        public func setGender(_ gender: Gender?) -> Self {
            var copy = self
            copy.self.gender = gender
            return copy
        }
        
        public func setWeight(_ weight: Double?) -> Self {
            var copy = self
            copy.self.weight = weight
            return copy
        }
        
        public func setHeight(_ height: Double?) -> Self {
            var copy = self
            copy.self.height = height
            return copy
        }
        
        public func setIsMarried(_ isMarried: Bool?) -> Self {
            var copy = self
            copy.self.isMarried = isMarried
            return copy
        }
        
        // setter로 값을 설정했다면 Builder 인스턴스의 build()를 호출하여 실제로 생성하려는 타입의 인스턴스를 생성하여 반환한다.
        // - setter로 설정한 속성이 생성자 매개변수로 전달되면서 해당 속성이 초기화된 상태로 반환된다.
        public func build() -> PersonWithBuilder {
            PersonWithBuilder(name: name, age: age, gender: gender, weight: weight, height: height, isMarried: isMarried)
        }
    }
}
