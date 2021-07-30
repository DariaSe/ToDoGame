//
//  ExperienceManager.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 04.07.2021.
//

import Foundation

class ExperienceManager {
    
    let defaultExperienceAmount: Double = 2.0
    
    var buffs: [Buff] = []
    
    var multiplier: Double { buffs.isEmpty ? 1 : buffs.map{$0.multiplier}.reduce(0){$0 * $1} }
    
    var experienceToAdd: Int { Int(defaultExperienceAmount * multiplier) }
    
    func incrementExperience() {
        UserDefaultsService.experience += experienceToAdd
    }
    
    func decrementExperience() {
        UserDefaultsService.experience -= experienceToAdd
    }
}
