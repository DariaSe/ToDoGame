//
//  Seed.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 20.08.2021.
//

import Foundation

struct Seed: InventoryItem {
    
    var species: PlantSpecies
    var title: String { species.title }
    var description: String { species.description }
    var imageName: String
    var buyCostGold: Int { species.buyCostGold }
    var buyCostDonation: Int { species.buyCostDonation }
    var levelRequired: Int { species.levelRequired }
    var quantity: Int
    
}
