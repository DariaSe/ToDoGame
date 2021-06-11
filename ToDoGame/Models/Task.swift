//
//  Task.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 07.05.2021.
//

import UIKit

struct Task: Codable {
    
    var id: Int
    var orderID: Int
    var title: String
    var startDate: Date
    var dueTime: String?
    var recurrenceRule: RecurrenceRule?
    var executionLog: [Date] = []
    var isNotificationOn: Bool
    var notificationTime: String?
    var color: Int
    var notes: String = ""
    
    func viewModel(isDone: Bool, date: Date) -> TaskViewModel {
        return TaskViewModel(id: id, orderID: orderID, title: title, isDone: isDone, date: date, time: dueTime, color: color)
    }
    
    static var sample: [Task] { [
        Task(id: 1, orderID: 1, title: "Task 1", startDate: Date(), recurrenceRule: RecurrenceRule.sample1,  isNotificationOn: false, color: 2),
        Task(id: 2, orderID: 2, title: "Task 2", startDate: Date(), recurrenceRule: RecurrenceRule.sample2, isNotificationOn: false, color: 6),
        Task(id: 3, orderID: 3, title: "Task 3", startDate: Date(), recurrenceRule: RecurrenceRule.sample3, isNotificationOn: false, color: 8),
        Task(id: 4, orderID: 4, title: "Task 4", startDate: Date(), isNotificationOn: false, color: 2)
    ] }
    
    //MARK: Decoding and encoding
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("tasks").appendingPathExtension("plist")
    
    static func saveToFile(tasks: [Task]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedTasks = try? propertyListEncoder.encode(tasks)
        try? encodedTasks?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Task]? {
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedTasksData = try? Data(contentsOf: archiveURL) else { return nil }
        return try? propertyListDecoder.decode(Array<Task>.self, from: retrievedTasksData)
    }
}

extension Task: Comparable {
    
    static func < (lhs: Task, rhs: Task) -> Bool {
        return lhs.orderID < rhs.orderID
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
    
}
