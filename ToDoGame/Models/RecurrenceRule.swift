//
//  RecurrenceRule.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 07.05.2021.
//

import Foundation

struct RecurrenceRule: Codable {
    
    var recurrenceFrequency: RecurrenceFrequency?
    var interval: Int?
    var weekdays: [Int]?
    
}

