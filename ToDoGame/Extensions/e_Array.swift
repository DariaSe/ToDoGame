//
//  e_Array.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 25.05.2021.
//

import Foundation

#warning("Test it")

extension Array where Element: Equatable {
    
    func containsOneOrMoreOf(array: [Element]) -> Bool {
        guard !array.isEmpty else { return true }
        for item in array {
            if self.contains(item) { return true }
        }
        return false
    }
    
    func without(_ element: Element) -> Self {
        return self.filter { $0 != element }
    }
    
    func replace(_ sourceElement: Element, with newElement: Element) -> Self {
        var arrayIndex: Int?
        for (index, element) in self.enumerated() {
            if element == sourceElement {
                arrayIndex = index
            }
        }
        var newArray = self
        guard let index = arrayIndex else { return self }
        newArray.remove(at: index)
        newArray.insert(newElement, at: index)
        return newArray
    }
}

