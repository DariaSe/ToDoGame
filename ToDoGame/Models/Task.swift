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
    var notes: String = ""
    var tags: [Tag] = []
    
    func viewModel(isDone: Bool, date: Date) -> TaskViewModel {
        return TaskViewModel(id: id, orderID: orderID, title: title, isDone: isDone, date: date, time: dueTime, tags: tags)
    }
    
    static var sample: [Task] { [Task(id: 1, orderID: 1, title: "Task 1", startDate: Date(), isNotificationOn: false, tags: [Tag(id: 1, title: "Work", color: 2)]), Task(id: 2, orderID: 2, title: "Task 2", startDate: Date(), isNotificationOn: false), Task(id: 3, orderID: 3, title: "Task 3", startDate: Date(), isNotificationOn: false, tags: [Tag(id: 1, title: "Work", color: 2), Tag(id: 2, title: "Entertainment", color: 7)])] }
    
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
