//
//  InventoryCoordinator.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 02.08.2021.
//

import UIKit

class InventoryCoordinator {
    
    let inventoryVC = InventoryViewController()
    
    func start() {
        inventoryVC.coordinator = self
        inventoryVC.tabBarItem = UITabBarItem(title: "Garden", image: UIImage(named: "Garden"), tag: 1)
    }
}
