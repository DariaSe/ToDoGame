//
//  p_ShopItem.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 02.08.2021.
//

import Foundation

protocol ShopItem {
    var title: String { get set }
    var description: String { get set }
    var imageName: String { get set }
    var buyCostGold: Int { get set }
    var buyCostDonation: Int { get set }
    var levelRequired: Int { get set }
}

