//
//  ToDoListViewController.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 24.04.2021.
//

import UIKit

class TaskListViewController: UIViewController {
    
    weak var coordinator: TaskListCoordinator?
    
    weak var delegate: TableViewCellDelegate?
    
    var toDoListView = TaskListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tasks"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        view.backgroundColor = .yellow
        view.setConstraints(on: toDoListView)
        toDoListView.delegate = delegate
    }
    
    @objc func addTask() {
        coordinator?.showAddTaskScreen()
    }
}


