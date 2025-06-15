import Foundation
import Playgrounds

// Swift 문법은 추상 클래스와 인터페이스를 지원하지 않는 대신, 프로토콜을 사용함
// - 프로토콜은 앞서 지원하지 않는 기능들과 거의 동일함
#Playground {
//    FactoryMethod.run()
//    AbstractFactory.run()
    ClassAdapter().doSomething(number: 10)
    
    // 내부에서 Target의 doSomething() 메서드 자리에 Adaptee()의 메서드가 대신 호출된다. -> 좀 더 직관적!
    ObjectAdapter(adaptee: Adaptee()).doSomething(number: 10)
}
