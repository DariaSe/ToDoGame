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
    var deleted: [Date] = []
    var isNotificationOn: Bool
    var notificationTime: String?
    var notes: String = ""
    var tags: [Tag] = []
    
    func viewModel(isDone: Bool, date: Date) -> TaskViewModel {
        return TaskViewModel(id: id, orderID: orderID, title: title, isDone: isDone, date: date, time: dueTime, tags: tags)
    }
    
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
