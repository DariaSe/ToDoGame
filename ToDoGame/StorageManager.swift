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
    
    func loadTags() -> [Tag] {
        return Tag.loadFromFile() ?? []
    }
    
    func save(tags: [Tag]) {
        Tag.saveToFile(tags: tags)
    }
    
    func getSelectedTags() -> [Int] {
        return UserDefaultsService.selectedTags
    }
    
    func saveSelectedTags(_ tagIDs: [Int]) {
        UserDefaultsService.selectedTags = tagIDs
    }
}
