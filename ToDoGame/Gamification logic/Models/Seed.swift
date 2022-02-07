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
    
    static let strawberry = Seed(species: .strawberry, imageName: "strawberry_seed", quantity: 1)
    static let apple = Seed(species: .apple, imageName: "apple_seed", quantity: 1)
    static let cherry = Seed(species: .cherry, imageName: "cherry_seed", quantity: 1)
    static let watermelon = Seed(species: .watermelon, imageName: "watermelon_seed", quantity: 1)
    static let coconut = Seed(species: .coconut, imageName: "coconut_seed", quantity: 1)
    static let chiliPepper = Seed(species: .chiliPepper, imageName: "chiliPepper_seed", quantity: 1)
    
    static let sample = [Seed.strawberry, .apple, .cherry, .watermelon, .coconut, .chiliPepper]
}
