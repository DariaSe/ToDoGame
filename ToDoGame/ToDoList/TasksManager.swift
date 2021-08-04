//
//  TasksManager.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 24.05.2021.
//

import Foundation

class TasksManager {
    
    let apiService = TasksAPIServiceMock()
    
    weak var coordinator: TaskListCoordinator?
    
    var tasks: [Task] = []
    
    func loadTasks(completion: @escaping ([Task], String?) -> Void) {
        apiService.getTasks { (tasks, error) in
            if let tasks = tasks, error == nil {
                self.tasks = tasks
                completion(tasks, nil)
            }
            else if let error = error {
                completion(Task.loadFromFile() ?? [], error)
            }
        }
    }
    
    func newTask(_ task: Task, completion: @escaping (Bool, String?) -> Void) {
        apiService.newTask(task) { (success, error) in
            if success, error == nil {
                
            }
        }
    }
    
    func editTask(_ editedTask: Task, completion: @escaping (Bool, String?) -> Void) {
        
    }
    
    func deleteTask(taskID: Int, completion: @escaping (Bool, String?) -> Void) {
        
    }
    
    func setCompletedOrCancel(taskID: Int, date: Date, completion: @escaping (Bool, String?) -> Void) {
        
    }
    
    func save(tasks: [Task]) {
        Task.saveToFile(tasks: tasks)
    }
}

