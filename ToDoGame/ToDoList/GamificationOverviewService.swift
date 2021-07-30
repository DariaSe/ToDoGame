//
//  GamificationOverviewService.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 06.07.2021.
//

import Foundation

class GamificationOverviewService {
    
    func setup(view: GamificationOverviewView, experience: Int, water: Int, gold: Int) {
        let level = LevelManager.level(for: experience)
        let nextLevelExp = LevelManager.nextLevelExp(currentExp: experience)
        view.setup(level: level, currentExp: experience, nextLevelExp: nextLevelExp, water: water, gold: gold)
    }
}
