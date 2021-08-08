//
//  TasksAPIServiceMock.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 04.08.2021.
//

import Foundation

class TasksAPIServiceMock: TasksAPIService {
    
    func getTasks(completion: @escaping ([Task]?, String?) -> Void) {
        completion(Task.loadFromFile(), nil)
    }
    
    func new(_ task: Task, completion: @escaping (Bool, String?) -> Void) {
        completion(true, nil)
    }
    
    func edit(_ task: Task, completion: @escaping (Bool, String?) -> Void) {
        completion(true, nil)
    }
    
    func delete(taskID: Int, completion: @escaping (Bool, String?) -> Void) {
        completion(true, nil)
    }
    
    func setCompletedOrCancel(taskID: Int, date: Date, completion: @escaping (Bool, String?) -> Void) {
        completion(true, nil)
    }
}
