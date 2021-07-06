//
//  Buff.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 04.07.2021.
//

import UIKit

struct Buff {
    var title: String
    var image: UIImage?
    var types: [BuffType]
    var multiplier: Double
    var levelRequired: Int = 1
}

enum BuffType: Int {
    case experience
    case gold
    case growth
    case yield
}
