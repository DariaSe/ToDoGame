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
    
    static var sample: [TaskViewModel] { [TaskViewModel(id: 1, orderID: 1, title: "Task 1", isDone: true, date: Date(), tags: [Tag(id: 1, title: "Work", color: 3)]), TaskViewModel(id: 2, orderID: 2, title: "Task 2", isDone: false, date: Date()), TaskViewModel(id: 3, orderID: 3, title: "Task 3", isDone: false, date: Date(), tags: [Tag(id: 1, title: "Work", color: 2), Tag(id: 2, title: "Entertainment", color: 7)]), TaskViewModel(id: 4, orderID: 4, title: "Task 4", isDone: true, date: Date())] }
    
}

extension TaskViewModel: Comparable {
    
    static func < (lhs: TaskViewModel, rhs: TaskViewModel) -> Bool {
        return lhs.orderID < rhs.orderID
    }
    
    static func == (lhs: TaskViewModel, rhs: TaskViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}
