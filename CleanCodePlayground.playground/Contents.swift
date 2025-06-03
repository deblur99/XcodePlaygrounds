import UIKit

// MARK: 01. Clean Code

func test01_1() {
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
}

func test01_2() {
    let vpcManager = VPCManager()
    
    // 1) 처리 성공 여부를 Bool로 표현하는 방식
    if (!vpcManager.deleteVPCResourceUsingBool()) {
        print("deleteVPCResourceUsingBool(): Some VPCs cannot be deleted.")
    }
    
    // 2) 처리 중 예외 발생 여부를 Typed Error 방식으로 표현하는 방식
    do {
        try vpcManager.deleteVPCResourceUsingException()
    } catch {
        // print(error.localizedDescription) // 원래는 이게 맞으나.. Playground 환경에서는 Error -> NSError 변환을 제대로 지원하지 않기 때문에 런타임 오류가 발생한다고 함
        print("deleteVPCResourceUsingException():", error.rawValue)   // 메서드 선언부에서 에러 타입을 지정했기 때문에 catch문에서 let error로 캡처하지 않아도 잘 출력됨!
    }
}

test01_2()
