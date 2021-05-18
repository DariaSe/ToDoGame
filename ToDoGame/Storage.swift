//
//  Storage.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 07.05.2021.
//

import Foundation

class Storage {
    
    var tasks: [Task] = []
    
    func fetchAllTasks() -> [Task] {
        return []
    }
    
    func write(task: Task, completion: (Bool, String) -> Void) {
        
    }
}
