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
    let waterManager = WaterManager()
    let goldManager = GoldManager()
    
    func loadBuffs() {
        
    }

    func didSetCompleted(completion: ((_ experience: Int, _ water: Int, _ gold: Int) -> Void)) {
        experienceManager.incrementExperience()
        waterManager.incrementWater()
        goldManager.incrementGold()
        completion(UserDefaultsService.experience, UserDefaultsService.water, UserDefaultsService.gold)
    }
    
    func didCancel(completion: ((_ experience: Int,  _ water: Int, _ gold: Int) -> Void)) {
        experienceManager.decrementExperience()
        waterManager.decrementWater()
        goldManager.decrementGold()
        completion(UserDefaultsService.experience, UserDefaultsService.water, UserDefaultsService.gold)
    }
}
