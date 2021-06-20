//
//  TaskListCoordinator.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 07.05.2021.
//

import UIKit

class TaskListCoordinator {
    
    let storageManager = StorageManager()
    let viewModelFactory = TaskViewModelFactory()
    
    let taskListVC = TaskListViewController()
    
    lazy var singleToDoVC = ViewController()
    
    var tasks: [Task] = [] {
        didSet {
            taskListVC.tasks = tasks.compactMap { viewModelFactory.makeTaskViewModel(from: $0, date: date) }
        }
    }
    
    var date: Date = Date() {
        didSet {
            taskListVC.tasks = tasks.compactMap { viewModelFactory.makeTaskViewModel(from: $0, date: date) }
        }
    }
    
    func start() {
        taskListVC.coordinator = self
        taskListVC.taskListView.swapDelegate = self
    }
    
    func getTasks() {
//        let tasks = storageManager.loadTasks()
        let tasks = Task.sample
        self.tasks = tasks.sorted()
    }
    
    func askForDeletion(taskID: Int) {
        guard let task = tasks.filter({ $0.id == taskID }).first else { return }
        let message = task.recurrenceRule != nil ? Strings.taskDeletionMessage : ""
        let alert = UIAlertController.deletionAlert(title: Strings.taskDeletionTitle, message: message) { [unowned self] (_) in
            deleteTask(taskID: taskID)
        }
        taskListVC.present(alert, animated: true, completion: nil)
    }
    
    func deleteTask(taskID: Int) {
        tasks = tasks.filter { $0.id != taskID }
//        storageManager.save(tasks: tasks)
    }
    
    func setCompletedOrCancel(taskID: Int) {
        guard let task = tasks.filter({ $0.id == taskID }).first else { return }
        var newTask = task
        if newTask.executionLog.contains(date.dayStart) {
            newTask.executionLog = newTask.executionLog.without(date.dayStart)
        }
        else {
            newTask.executionLog.append(date.dayStart)
        }
        tasks = tasks.replace(task, with: newTask)
    }
    
    func openTask(id: Int) {
        guard let task = tasks.filter({ $0.id == id }).first else { return }
        let vc = SingleTaskViewController()
        vc.task = task
        taskListVC.present(vc, animated: true, completion: nil)
    }
    
    func showAddTaskScreen() {
        let vc = SingleTaskViewController()
        taskListVC.present(vc, animated: true, completion: nil)
    }
    
}

extension TaskListCoordinator: SwapDelegate {
    
    func swapTasks(firstID: Int, secondID: Int) {
        guard var firstTask = tasks.filter({ $0.id == firstID }).first,
              var secondTask = tasks.filter({ $0.id == secondID }).first else { return }
        let firstOrderID = firstTask.orderID
        let secondOrderID = secondTask.orderID
        firstTask.orderID = secondOrderID
        secondTask.orderID = firstOrderID
        tasks = tasks.replace(firstTask, with: firstTask)
        tasks = tasks.replace(secondTask, with: secondTask)
        tasks = tasks.sorted()
    }
}
