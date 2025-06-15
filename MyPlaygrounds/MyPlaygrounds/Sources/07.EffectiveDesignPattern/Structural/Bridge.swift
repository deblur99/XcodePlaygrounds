//
//  Bridge.swift
//  MyPlaygrounds
//
//  Created by 한현민 on 6/15/25.
//

import Foundation
import Playgrounds

// 구현부: 추상 계층 구현체의 생성자를 통해 주입
protocol Color {
    func name() -> String
}

struct Red: Color {
    func name() -> String {
        "red"
    }
}

struct Yellow: Color {
    func name() -> String {
        "yellow"
    }
}

struct Green: Color {
    func name() -> String {
        "green"
    }
}

// 추상 계층: 구현부를 인스턴스로 가짐
protocol Tool {
    var color: Color { get }
    
    func draw()
}

struct Pencil: Tool {
    let color: Color
    
    func draw() {
        print("draws using \(color.name()) pencil.")
    }
}

struct Brush: Tool {
    let color: Color
    
    func draw() {
        print("draws using \(color.name()) brush.")
    }
}

#Playground {
    let pencil: Tool = Pencil(color: Red())
    let brush: Tool = Brush(color: Green())
    
    pencil.draw()
    brush.draw()
}
