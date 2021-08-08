//
//  Stone.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 05.08.2021.
//

import Foundation

struct Stone: ShopItem {
    var title: String
    var description: String
    var imageName: String
    var buyCostGold: Int
    var buyCostDonation: Int
    var levelRequired: Int
    var type: StoneType
}

enum StoneType: Int {
    case garnet
    case amber
}
