//
//  Task.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 07.05.2021.
//

import Foundation

struct Task: Codable, Orderable {
    
    var id: Int
    var orderID: Int
    var title: String
    var startDate: Date
    var time: String? {
        let startDateStart = startDate.dayStart
        var time: String?
        if startDateStart != startDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            time = formatter.string(from: startDate)
        }
        return time
    }
    var recurrenceRule: RecurrenceRule?
    var executionLog: [Date] = []
    var tasksCompleted: Int {
        print(executionLog.count)
        return executionLog.count
    }
    var tasksTotal: Int {
        var date = startDate
        var taskModels = [TaskViewModel]()
        let factory = TaskViewModelFactory()
        repeat {
            if let taskModel = factory.makeTaskViewModel(from: self, date: date) {
                taskModels.append(taskModel)
            }
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        } while date <=^ Date()
        print(taskModels.count)
        return taskModels.count
    }
    var notificationOption: Int?
    var color: Int?
    var notes: String = ""
    
    func viewModel(isDone: Bool, date: Date) -> TaskViewModel {
        return TaskViewModel(id: id, orderID: orderID, title: title, isDone: isDone, date: date, time: time, color: color)
    }
    
    var closestDate: Date {
        if let recurrenceRule = self.recurrenceRule {
            var date = Date()
            while !date.matches(startDate: startDate, recurrenceRule: recurrenceRule) {
                date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            }
            return date
        }
        else {
            return startDate
        }
    }
    
    static var sample: [Task] { [
        Task(id: 1, orderID: 1, title: "Task 1", startDate: Date(), recurrenceRule: RecurrenceRule.sample1,  color: 2),
        Task(id: 2, orderID: 2, title: "Task 2", startDate: Date(), recurrenceRule: RecurrenceRule.sample2, color: 6),
        Task(id: 3, orderID: 3, title: "Task 3", startDate: Date(), recurrenceRule: RecurrenceRule.sample3, color: 8),
        Task(id: 4, orderID: 4, title: "Task 4", startDate: Date(), color: 2)
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

protocol Orderable {
    var orderID: Int { get set }
}

class TaskViewModelFactory {
    
    func makeTaskViewModel(from task: Task, date: Date) -> TaskViewModel? {
        guard task.recurrenceRule != nil else {
            return singleTaskViewModel(from: task, date: date)
        }
        // search if there is executed task on that day
        let executedOnDate = task.executionLog.map { $0.dayStart }.filter { $0 == date.dayStart }
        if !executedOnDate.isEmpty {
            return task.viewModel(isDone: true, date: executedOnDate.first!)
        }
        else {
            return recurrenceTaskViewModel(from: task, date: date)
        }
        
    }
    
    private func singleTaskViewModel(from task: Task, date: Date) -> TaskViewModel? {
        // if task is already executed
        if let executionDate = task.executionLog.first {
            return executionDate ==^ date ? task.viewModel(isDone: true, date: executionDate) : nil
        }
        // if task is active
        else {
            return task.startDate ==^ date ? task.viewModel(isDone: false, date: task.startDate) : nil
        }
    }
    
    private func recurrenceTaskViewModel(from task: Task, date: Date) -> TaskViewModel? {
        let startDate = task.startDate
        guard let recurrenceRule = task.recurrenceRule else { return nil }
        return date.matches(startDate: startDate, recurrenceRule: recurrenceRule) ? task.viewModel(isDone: false, date: date) : nil
    }
}
