//
//  Storage.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 07.05.2021.
//

import Foundation

class StorageManager {
    
    func loadTasks() -> [Task] {
        return Task.loadFromFile() ?? []
    }
    
    func save(tasks: [Task]) {
        Task.saveToFile(tasks: tasks)
    }
}
