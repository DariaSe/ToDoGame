//
//  MainTabBarController.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 02.08.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let taskListCoordinator = TaskListCoordinator()
    let inventoryCoordinator = InventoryCoordinator()
    let questsCoordinator = QuestsCoordinator()

    override func viewDidLoad() {
        super.viewDidLoad()
        taskListCoordinator.start()
        inventoryCoordinator.start()
        questsCoordinator.start()
        viewControllers = [taskListCoordinator.taskListVC,
                           inventoryCoordinator.inventoryVC,
                           questsCoordinator.questsVC]
    }
}
