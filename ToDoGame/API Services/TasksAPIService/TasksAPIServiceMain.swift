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
    
    func newTask(_ task: Task, completion: @escaping (Bool, String?) -> Void) {
        
    }
    
    func editTask(_ editedTask: Task, completion: @escaping (Bool, String?) -> Void) {
        
    }
    
    func deleteTask(taskID: Int, completion: @escaping (Bool, String?) -> Void) {
        
    }
    
    func setCompletedOrCancel(taskID: Int, date: Date, completion: @escaping (Bool, String?) -> Void) {
        
    }
}
