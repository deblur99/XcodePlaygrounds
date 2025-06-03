import UIKit

// MARK: 01. Clean Code

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
