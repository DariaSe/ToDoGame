//
//  TasksManager.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 24.05.2021.
//

import Foundation

class TasksManager {
    
    let apiService = TasksAPIServiceMock()
//    let coreDataManager = TaskCoreDataManager()
    
    weak var coordinator: TaskListCoordinator?
    
    var tasks: [Task] = [] {
        didSet {
            coordinator?.tasks = tasks
        }
    }
  
    func loadTasks() {
        apiService.getTasks { [unowned self] (tasks, error) in
            DispatchQueue.main.async {
                if let tasks = tasks, error == nil {
                    self.tasks = tasks
                }
                else if let error = error {
                    self.tasks = Task.loadFromFile() ?? []
                    coordinator?.showError(error)
                }
            }
        }
    }
    
    func save(_ task: Task) {
        if let existingTask = tasks.filter({$0.id == task.id}).first {
            apiService.edit(task) { [unowned self] (success, error) in
                DispatchQueue.main.async {
                    if success, error == nil {
                        tasks.replace(existingTask, with: task)
                        Task.saveToFile(tasks: tasks)
                    }
                    else if let error = error {
                        coordinator?.showError(error)
                    }
                }
            }
        }
        else {
            apiService.new(task) { [unowned self] (success, error) in
                DispatchQueue.main.async {
                    if success, error == nil {
                        tasks.append(task)
                        Task.saveToFile(tasks: tasks)
                    }
                    else if let error = error {
                        coordinator?.showError(error)
                    }
                }
            }
        }
    }
    
    
    func deleteTask(taskID: Int, completion: @escaping (Bool, String?) -> Void) {
        
    }
    
    func setCompletedOrCancel(taskID: Int, date: Date, completion: @escaping (Bool, String?) -> Void) {
        
    }
}

