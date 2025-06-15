//
//  Composite.swift
//  MyPlaygrounds
//
//  Created by 한현민 on 6/15/25.
//

import Foundation
import Playgrounds

// Component: Leaf와 Composite를 동일한 방식으로 다룰 수 있게 함
protocol Item {
    func displayName()
}

// Leaf: Composite의 자식 요소로 취급
struct NormalItem: Item {
    let name: String
    
    func displayName() {
        print("Normal Item: \(name)")
    }
}

// Composite: Leaf를 포함하는 부모 요소
struct StorageItem: Item {
    let name: String
    var items: Array<Item>
    
    func displayName() {
        print(">> \(name)")
        items.forEach { $0.displayName() }
    }
    
    mutating func addItem(_ item: Item) {
        items.append(item)
    }
    
    mutating func removeItem(at index: Int) {
        items.remove(at: index)
    }
}

#Playground {
    var storageItem = StorageItem(name: "Storage", items: [
        NormalItem(name: "Item 1"),
        NormalItem(name: "Item 2"),
        StorageItem(name: "Sub Storage", items: [
            NormalItem(name: "Sub Item 1"),
            NormalItem(name: "Sub Item 2"),
            NormalItem(name: "Sub Item 3"),
        ]),
    ])
    
    storageItem.displayName()
//    storageItem.addItem(NormalItem(name: "Item 3"))
//    storageItem.displayName()
//    storageItem.removeItem(at: 1)
//    storageItem.displayName()
}
