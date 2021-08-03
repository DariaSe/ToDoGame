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
    let shopCoordinator = ShopCoordinator()
    let questsCoordinator = QuestsCoordinator()

    override func viewDidLoad() {
        super.viewDidLoad()
        taskListCoordinator.start()
        taskListCoordinator.getTasks()
        inventoryCoordinator.start()
        shopCoordinator.start()
        questsCoordinator.start()
        viewControllers = [taskListCoordinator.taskListVC,
                           inventoryCoordinator.inventoryVC,
                           shopCoordinator.shopVC,
                           questsCoordinator.questsVC]
    }
}
