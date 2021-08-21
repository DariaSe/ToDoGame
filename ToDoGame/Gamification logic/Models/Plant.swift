//
//  Plant.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 27.07.2021.
//

import Foundation

struct Plant {
    var species: PlantSpecies
    var instanceID: Int
    var imageURL: String
    var age: Int = 0
    var plantingDate: Date?
    var wateringDates: [Date] = []
    var fertilizerDates: [Date] = []
    var state: PlantState = .seed
    var magic: Magic?
    var specialAttribute: SpecialAttribute?
}

enum PlantState: Int {
    case seed
    case sprout
    case growing
    case adult
    case blooming
    case fruiting
    case driedI
    case driedII
    case dead
    case restored
    case hibernated
}

enum Magic: Int {
    case fire
    case water
    case wind
    case earth
    case frost
    case electricity
    case poison
}

enum SpecialAttribute {
    case invisibility
    case teleportation
}
