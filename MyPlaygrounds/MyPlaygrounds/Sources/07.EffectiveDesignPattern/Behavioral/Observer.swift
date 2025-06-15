//
//  Observer.swift
//  MyPlaygrounds
//
//  Created by 한현민 on 6/15/25.
//

import Foundation
import Playgrounds

struct PublishedMessage: Sendable {
    let message: String
}

// Subject: 관찰 대상이 되는 주제
protocol Subject {
    var observerList: [Observer] { get set }
    
    func registerObserver(_ observer: Observer)
    func removeObserver(_ observer: Observer)
    func notifyObservers(message: PublishedMessage)
}

final class YoutubeChannel: Subject {
    var observerList: [Observer] = []
    
    func registerObserver(_ observer: Observer) {
        self.observerList.append(observer)
    }
        
    func removeObserver(_ observer: Observer) {
        self.observerList.removeAll(where: { $0.isEqual(to: observer) })
    }
    
    func notifyObservers(message: PublishedMessage) {
        // 옵저버에 이벤트 값 방출
        print("YoutubeChannel: new video published")
        for observer in self.observerList {
            observer.notify(message: message)
        }
    }
}

// Observer: Subject를 구독하고 있다가, Subject에서 notify()를 통해 이벤트가 방출되면 해당 이벤트를 notify에서 받아 실행
// + 프로토콜의 extension에서 프로토콜 채택은 불가능하다. 대신 프로토콜의 선언부에서는 가능하다.
// + 그리고, 프로토콜 내부에서는 메서드를 구현할 수 없기 때문에 extension 내부에서 채택한 프로토콜의 메서드를 구현해줘야 한다.
protocol Observer {
    var uuid: UUID { get }
    
    func notify(message: PublishedMessage)
    
    // 프로토콜에서는 Equatable 대신에 비교 메서드를 사용
    func isEqual(to other: Observer) -> Bool
}

extension Observer {
    // 그리고 프로토콜의 익스텐션에서 기본 메서드 구현해서 사용
    func isEqual(to other: Observer) -> Bool {
        self.uuid == other.uuid
    }
}

final class MyObserver: Observer {
    var uuid: UUID = .init()
    
    // 방출된 값 받기
    func notify(message: PublishedMessage) {
        print("MyObserver:", message.message)
    }
}

#Playground {
    let subject = YoutubeChannel()
    let observer1 = MyObserver()
    let observer2 = MyObserver()
    let observer3 = MyObserver()
    let observer4 = MyObserver()
    
    for observer in [observer1, observer2, observer3, observer4] {
        subject.registerObserver(observer)
    }
    
    subject.notifyObservers(message: .init(message: "Hello World!"))
}
