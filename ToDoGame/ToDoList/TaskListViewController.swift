//
//  ToDoListViewController.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 24.04.2021.
//

import UIKit

class TaskListViewController: UIViewController {
    
    weak var coordinator: TaskListCoordinator?
    
    var tasks: [TaskViewModel] = [] {
        didSet {
            taskListView.tasks = tasks
        }
    }
    
    var emptyMessageView = UIView()
    var taskListView = TaskListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tasks"
        view.backgroundColor = UIColor.backgroundColor
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        view.setConstraints(on: taskListView)
        taskListView.setCompletedOrCancel = { [unowned self] taskID in
            coordinator?.setCompletedOrCancel(taskID: taskID)
        }
        taskListView.deleteTask = { [unowned self] taskID in
            coordinator?.askForDeletion(taskID: taskID)
        }
    }
    
    @objc func addTask() {
        coordinator?.showAddTaskScreen()
    }
}


