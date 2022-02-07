//
//  Fruits.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 05.08.2021.
//

import Foundation

struct Fruit: InventoryItem {
    var species: PlantSpecies
    var title: String { species.title }
    var imageName: String
    var sellCost: Int
    var pcsForFertilizer: Int
    var quantity: Int
    
    static let sample2 = Fruit(species: .strawberry, imageName: "strawberry_fruit", sellCost: 1, pcsForFertilizer: 1, quantity: 11)
    static let sample3 = Fruit(species: .coconut, imageName: "coconut_fruit", sellCost: 1, pcsForFertilizer: 1, quantity: 2)
    static let sample4 = Fruit(species: .cherry, imageName: "cherry_fruit", sellCost: 1, pcsForFertilizer: 1, quantity: 22)
    static let sample5 = Fruit(species: .watermelon, imageName: "watermelon_fruit", sellCost: 1, pcsForFertilizer: 1, quantity: 1)
    static let sample6 = Fruit(species: .chiliPepper, imageName: "chiliPepper_fruit", sellCost: 1, pcsForFertilizer: 1, quantity: 6)
    static let sample7 = Fruit(species: .apple, imageName: "apple_fruit", sellCost: 1, pcsForFertilizer: 1, quantity: 10)
    static let sample8 = Fruit(species: .avocado, imageName: "avocado_fruit", sellCost: 1, pcsForFertilizer: 1, quantity: 2)
    static let sample = [Fruit.sample2, .sample3, .sample4, .sample5, .sample6, .sample7, .sample8]
}
