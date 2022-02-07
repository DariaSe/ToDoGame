//
//  Stone.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 05.08.2021.
//

import Foundation

struct Stone: ShopItem, InventoryItem {
    var id: Int
    var title: String
    var description: String
    var imageName: String
    var buyCostGold: Int
    var buyCostDonation: Int
    var sellCost: Int
    var levelRequired: Int
    var type: StoneType
    var quantity: Int
}

enum StoneType: Int {
    case garnet
    case tourmaline
    case rhinestone
    case morion
}
