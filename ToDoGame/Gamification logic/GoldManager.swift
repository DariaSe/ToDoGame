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
    
    func incrementGold() {
        var multiplier = 1.0
        if !buffs.isEmpty {
            multiplier = buffs.map{$0.multiplier}.reduce(0){$0 * $1}
        }
        let goldToAdd = Int(defaultGoldAmount * multiplier)
        UserDefaultsService.gold += goldToAdd
    }
}
