//
//  Potion.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 05.08.2021.
//

import Foundation

struct Potion {
    var title: String
    var description: String
    var imageName: String
    var buyCostGold: Int
    var buyCostDonation: Int
    var levelRequired: Int
    var power: Int
    var effectDuration: Int?
    var effect: PotionEffect
}

enum PotionEffect: Int {
    case experienceBuff
    case goldBuff
    case waterBuff
    case yieldBuff
    case invisibility
    case teleportation
}
