//
//  Potion.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 05.08.2021.
//

import Foundation

struct Potion: InventoryItem {
    var id: Int
    var title: String
    var description: String
    var imageName: String
    var buyCostGold: Int
    var buyCostDonation: Int
    var sellCost: Int
    var levelRequired: Int
    var power: Int
    var effectDuration: Int?
    var type: PotionType
    var quantity: Int
}

enum PotionType: Int {
    case fire
    case water
    case air
    case earth
    case human
    case invisibility
    case teleportation
    case portalOpening
    case hibernation
}

enum BuffType: Int {
    case experience
    case gold
    case water
    case yield
}
