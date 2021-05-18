//
//  TaskListCoordinator.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 07.05.2021.
//

import UIKit

class TaskListCoordinator {
    
    let taskListVC = TaskListViewController()
    
    lazy var singleToDoVC = ToDoViewController()
    
    func start() {
        taskListVC.coordinator = self
        taskListVC.delegate = self
    }
    
    func getTasks() {
        
    }
    
    func openTask(id: Int) {
        
    }
    
    func showAddTaskScreen() {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        taskListVC.present(vc, animated: true, completion: nil)
    }
    
}

extension TaskListCoordinator: TableViewCellDelegate {
    
    func checkButtonPressed() {
        print("pressed")
    }
}
