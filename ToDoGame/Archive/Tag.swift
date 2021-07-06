//
//  Tag.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 04.07.2021.
//

import Foundation

struct Tag {
    
    var id: Int
    var title: String
    var color: Int
    
    static var sample: [Tag] { [Tag(id: 1, title: "Work", color: 2), Tag(id: 2, title: "Entertainment", color: 7), Tag(id: 3, title: "Others", color: 5)]}
}
