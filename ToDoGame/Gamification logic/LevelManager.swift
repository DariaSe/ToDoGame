//
//  LevelManager.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 06.07.2021.
//

import Foundation

class LevelManager {
    
    static let levels: [Int : Int] = [
        1 : 0,
        2 : 10,
        3 : 30,
        4 : 60,
        5 : 100,
        6 : 180,
        7 : 300,
        8 : 550,
        9 : 750,
        10 : 1000,
        11 : 1350,
        12 : 1800,
        13 : 2400,
        14 : 3100,
        15 : 4000,
        16 : 5000,
        17 : 7500,
        18 : 11000,
        19 : 15000,
        20 : 20000,
        21 : 30000,
        22 : 45000,
        23 : 65000,
        24 : 90000,
        25 : 120000,
        26 : 155000,
        27 : 190000,
        28 : 220000,
        29 : 255000,
        30 : 300000
    ]
    
    static func level(for currentExp: Int) -> Int {
        let filteredLevels = levels.filter{$0.value <= currentExp}
        let levelExp = filteredLevels.map{$0.value}.sorted(by: >).first ?? 0
        let level = levels.filter{$0.value == levelExp}.first!.0
        return level
        
    }
    
    static func nextLevelExp(currentExp: Int) -> Int {
        
        return levels[level(for: currentExp) + 1] ?? 300000
        
    }
}
