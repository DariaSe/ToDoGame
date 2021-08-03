//
//  QuestsCoordinator.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 02.08.2021.
//

import UIKit

class QuestsCoordinator {
    
    let questsVC = QuestsViewController()
    
    func start() {
        questsVC.coordinator = self
        questsVC.tabBarItem = UITabBarItem(title: "Quests", image: UIImage(named: "Quests"), tag: 3)
    }
    
}
