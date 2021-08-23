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
}
