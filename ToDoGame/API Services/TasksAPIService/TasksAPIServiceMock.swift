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
    
    func newTask(_ task: Task, completion: @escaping (Bool, String?) -> Void) {
        completion(true, nil)
    }
    
    func editTask(_ editedTask: Task, completion: @escaping (Bool, String?) -> Void) {
        completion(true, nil)
    }
    
    func deleteTask(taskID: Int, completion: @escaping (Bool, String?) -> Void) {
        completion(true, nil)
    }
    
    func setCompletedOrCancel(taskID: Int, date: Date, completion: @escaping (Bool, String?) -> Void) {
        completion(true, nil)
    }
}
