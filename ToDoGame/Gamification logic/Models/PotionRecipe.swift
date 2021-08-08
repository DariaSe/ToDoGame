//
//  PotionRecipe.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 05.08.2021.
//

import Foundation

struct PotionRecipe: ShopItem {
    var title: String
    var description: String
    var imageName: String
    var buyCostGold: Int
    var buyCostDonation: Int
    var levelRequired: Int
    var fruits: [Fruits]
    var stone: Stone
    var firewood: Int
    var oil: Int
}
