//
//  TasksAPIServiceMain.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 04.08.2021.
//

import Foundation

class TasksAPIServiceMain: TasksAPIService {
    
    func getTasks(completion: @escaping ([Task]?, String?) -> Void) {
        
    }
    
    func new(_ task: Task, completion: @escaping (Bool, String?) -> Void) {
        
    }
    
    func edit(_ task: Task, completion: @escaping (Bool, String?) -> Void) {
        
    }
    
    func delete(taskID: Int, completion: @escaping (Bool, String?) -> Void) {
        
    }
    
    func setCompletedOrCancel(taskID: Int, date: Date, completion: @escaping (Bool, String?) -> Void) {
        
    }
}
