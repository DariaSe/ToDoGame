//
//  TasksManager.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 24.05.2021.
//

import Foundation

class TasksManager {
    
    var tasks: [TaskViewModel] = []
    
    var activeTasks: [TaskViewModel] { tasks.filter { !$0.isDone } }
    var completedTasks: [TaskViewModel] { tasks.filter { $0.isDone } }
    
}

