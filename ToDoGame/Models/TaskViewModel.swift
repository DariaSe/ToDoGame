//
//  TaskViewModel.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 17.05.2021.
//

import Foundation

struct TaskViewModel {
    
    var id: Int
    var orderID: Int
    var title: String
    var isDone: Bool
    var date: Date
    var time: String?
    var tags: [Tag] = []
    
}
