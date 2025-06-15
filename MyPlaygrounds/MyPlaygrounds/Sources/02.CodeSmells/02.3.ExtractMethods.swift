//
//  02.3.ExtractMethods.swift
//  Playgrounds
//
//  Created by 한현민 on 6/7/25.
//

import Foundation

public final class ExtractMethods {
    public struct Student {
        let score: Int
    }
    
    var students = [Student]()
    
    // 별도의 매개변수 없이, 다른 저장 속성에 의해 산출되는 값은 연산 프로퍼티로 표현
    var average: Int {
        var sum = 0
        
        for student in students {
            sum += student.score
        }
        
        return sum / students.count
    }
    
    public init() {
        initStudents()
        
        let myScore = 75
        if average < myScore {
            print("Good score")
        } else {
            print("Poor score")
        }
    }
    
    func initStudents() {
        students = []
        students.append(.init(score: 50))
        students.append(.init(score: 90))
        students.append(.init(score: 86))
        students.append(.init(score: 60))
        students.append(.init(score: 80))
    }
}
