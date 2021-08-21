//
//  TaskListCoordinator.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 07.05.2021.
//

import UIKit

class TaskListCoordinator {
    
    let storageManager = StorageManager()
    let tasksManager = TasksManager()
    let viewModelFactory = TaskViewModelFactory()
    
    let taskListVC = TaskListViewController()
    
    lazy var singleToDoVC = ViewController()
    
    let tasksUserCoordinator = TasksUserCoordinator()
    
    var tasks: [Task] = [] {
        didSet {
            taskListVC.tasks = taskModels
        }
    }
    
    var taskModels: [TaskViewModel] {
        tasks.compactMap { viewModelFactory.makeTaskViewModel(from: $0, date: date) }
    }
    
    var swapTaskModels: [TaskViewModel] = []
    
    var date: Date = Date() {
        didSet {
            taskListVC.tasks = tasks.compactMap { viewModelFactory.makeTaskViewModel(from: $0, date: date) }
        }
    }
    
    func start() {
        taskListVC.tabBarItem = UITabBarItem(title: "Tasks", image: UIImage(named: "TaskList"), tag: 0)
        taskListVC.coordinator = self
        taskListVC.taskListView.swapDelegate = self
        tasksManager.coordinator = self
        loadCachedTasks()
        getTasks()
        updateGameUI()
        NotificationCenter.default.addObserver(self, selector: #selector(updateGameUI), name: .userChanged, object: nil)
    }
    
    @objc func updateGameUI() {
        let user = UserService.shared.user
        let level = LevelManager.currentLevel
        let nextLevelExp = LevelManager.nextLevelExp
        taskListVC.gamificationOverview.setup(level: level, currentExp: user.experience, nextLevelExp: nextLevelExp, water: user.water, maxWater: user.waterCapacity, gold: user.gold)
    }
    
    func loadCachedTasks() {
        let cachedTasks = Task.loadFromFile() ?? []
        tasks = cachedTasks.sorted()
    }
    
    func getTasks() {
        tasksManager.loadTasks()
    }
    
    func askForDeletion(taskID: Int) {
        guard let task = tasks.filter({ $0.id == taskID }).first else { return }
        let message = task.recurrenceRule != nil ? Strings.taskDeletionMessage : ""
        let alert = UIAlertController.deletionAlert(title: Strings.taskDeletionTitle, message: message) { [unowned self] (_) in
            deleteTask(taskID: taskID)
        }
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(alert, animated: true, completion: nil)
        }
    }
    
    func deleteTask(taskID: Int) {
        tasksManager.deleteTask(taskID: taskID) { [unowned self] (success, error) in
            if success, error == nil {
                DispatchQueue.main.async {
                    if var topController = UIApplication.shared.keyWindow?.rootViewController {
                        while let presentedViewController = topController.presentedViewController {
                            topController = presentedViewController
                        }
                        if topController != taskListVC {
                            topController.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
        tasks = tasks.filter { $0.id != taskID }
        
        storageManager.save(tasks: tasks)
    }
    
    func setCompletedOrCancel(taskID: Int) {
        guard let task = tasks.filter({ $0.id == taskID }).first else { return }
        var newTask = task
        if newTask.executionLog.contains(date.dayStart) {
            newTask.executionLog = newTask.executionLog.without(date.dayStart)
            tasksUserCoordinator.cancel()
        }
        else {
            newTask.executionLog.append(date.dayStart)
            tasksUserCoordinator.setCompleted()
        }
        tasks.replace(task, with: newTask)
        storageManager.save(tasks: tasks)
    }
    
    func openTask(id: Int) {
        guard let task = tasks.filter({ $0.id == id }).first else { return }
        let vc = SingleTaskViewController()
        vc.coordinator = self
        vc.task = task
        taskListVC.present(vc, animated: true, completion: nil)
    }
    
    func showAddTaskScreen(date: Date) {
        let vc = SingleTaskViewController()
        vc.coordinator = self
        vc.selectedDate = date
        let nextID = (tasks.map{$0.id}.sorted().last ?? 0) + 1
        let nextOrderID = (tasks.map{$0.orderID}.sorted().last ?? 0) + 1
        vc.nextID = nextID
        vc.nextOrderID = nextOrderID
        taskListVC.present(vc, animated: true, completion: nil)
    }
    
    func save(task: Task) {
        tasksManager.save(task)
        taskListVC.date = task.closestDate
    }
    
    func showError(_ error: String) {
        taskListVC.showError(error)
    }
}

extension TaskListCoordinator: SwapDelegate {
    
    func beginSwapping() {
        swapTaskModels = taskModels
    }
    
    func swap(firstID: Int, secondID: Int) {
        guard var firstTaskModel = swapTaskModels.filter({ $0.id == firstID }).first,
              var secondTaskModel = swapTaskModels.filter({ $0.id == secondID }).first else { return }
        let firstOrderID = firstTaskModel.orderID
        let secondOrderID = secondTaskModel.orderID
        firstTaskModel.orderID = secondOrderID
        secondTaskModel.orderID = firstOrderID
        swapTaskModels.replace(firstTaskModel, with: firstTaskModel)
        swapTaskModels.replace(secondTaskModel, with: secondTaskModel)
        swapTaskModels = swapTaskModels.sorted()
    }
    
    func endSwapping() {
        var changedTasks = tasks
        for taskModel in swapTaskModels {
            changedTasks = changedTasks.map({ (task) -> Task in
                if task.id == taskModel.id {
                    var changedTask = task
                    changedTask.orderID = taskModel.orderID
                    return changedTask
                }
                else {
                    return task
                }
            })
        }
        tasks = changedTasks.sorted()
        storageManager.save(tasks: tasks)
    }
}
