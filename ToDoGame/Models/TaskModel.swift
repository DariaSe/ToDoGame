//
//  Task.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 07.05.2021.
//

import UIKit

struct TaskModel {
    
    var id: Int
    var orderID: Int
    var title: String
    var startDate: Date
    var dueTime: String?
    var recurrenceRule: RecurrenceRule?
    var executionLog: [Date] = []
    var deleted: [Date] = []
    var isNotificationOn: Bool
    var notificationTime: String?
    var notes: String = ""
    var tags: [Tag] = []
    
    func viewModel(isDone: Bool, date: Date) -> TaskViewModel {
        return TaskViewModel(id: id, orderID: orderID, title: title, isDone: isDone, date: date, time: dueTime, tags: tags)
    }
}
