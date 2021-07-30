//
//  WaterManager.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 29.07.2021.
//

import Foundation

class WaterManager {
    
    let defaultWaterAmount: Double = 2.0
    
    var buffs: [Buff] = []
    
    var multiplier: Double { buffs.isEmpty ? 1 : buffs.map{$0.multiplier}.reduce(0){$0 * $1} }
    
    var waterToAdd: Int { Int(defaultWaterAmount * multiplier) }
    
    func incrementWater() {
        UserDefaultsService.water += waterToAdd
    }
    
    func decrementWater() {
        UserDefaultsService.water -= waterToAdd
    }
}
