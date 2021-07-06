//
//  GameCoordinator.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 26.06.2021.
//

import Foundation

class GameCoordinator {
    
    weak var taskCoordinator: TaskListCoordinator?
    
    let experienceManager = ExperienceManager()
    let goldManager = GoldManager()
    
    func loadBuffs() {
        
    }

    func didSetCompleted(completion: ((_ experience: Int, _ gold: Int) -> Void)) {
        experienceManager.incrementExperience()
        goldManager.incrementGold()
        completion(UserDefaultsService.experience, UserDefaultsService.gold)
    }
}
