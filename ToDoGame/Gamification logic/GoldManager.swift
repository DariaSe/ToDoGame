//
//  GoldManager.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 04.07.2021.
//

import Foundation

class GoldManager {
    
    let defaultGoldAmount: Double = 3.0
    
    var buffs: [Buff] = []
    
    var multiplier: Double { buffs.isEmpty ? 1 : buffs.map{$0.multiplier}.reduce(0){$0 * $1} }
    
    var goldToAdd: Int { Int(defaultGoldAmount * multiplier) }
    
    func incrementGold() {
        UserDefaultsService.gold += goldToAdd
    }
    
    func decrementGold() {
        UserDefaultsService.gold -= goldToAdd
    }
}
