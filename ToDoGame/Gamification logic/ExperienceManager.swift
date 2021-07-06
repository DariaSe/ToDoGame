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
    
    func incrementExperience() {
        var multiplier = 1.0
        if !buffs.isEmpty {
            multiplier = buffs.map{$0.multiplier}.reduce(0){$0 * $1}
        }
        let experienceToAdd = Int(defaultExperienceAmount * multiplier)
        UserDefaultsService.experience += experienceToAdd
    }
}
