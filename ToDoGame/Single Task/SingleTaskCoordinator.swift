//
//  SingleTaskCoordinator.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 07.05.2021.
//

import UIKit

class SingleTaskCoordinator {
    
    let singleTaskVC = SingleTaskViewController()
    
    func start() {
        singleTaskVC.coordinator = self
    }
    
    func save(task: Task?) {
       
    }
}
