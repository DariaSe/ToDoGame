//
//  Plant.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 27.07.2021.
//

import Foundation

struct PlantSpecies {
    var id: Int
    var title: String
    var description: String
    var buyCostGold: Int
    var buyCostDonation: Int?
    var sellCost: Int
    var type: PlantType
    var waterConsumption: Int
    var fertilizerConsumption: Int
    var fertilizerOutput: Int?
    var firewoodOutput: Int?
    var levelRequired: Int
    var daysTilBlooming: Int
    var daysTilHarvest: Int
    var nominalYield: Int
    var fruitingDuration: Int
}

struct Plant {
    var species: PlantSpecies
    var instanceID: Int
    var imageURL: String
    var age: Int
    var plantingDate: Date?
    var wateringDates: [Date] = []
    var state: PlantState
    var magic: Magic?
    var specialAttribute: SpecialAttribute?
}

enum PlantType: Int {
    case bush
    case tree
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
    case electricity
    case poison
}

enum SpecialAttribute {
    case invisibility
    case teleportation
    case soulTranslocation
}


//— стоимость покупки в золоте -
//— стоимость покупки в донатной валюте -
//— стоимость продажи (семечки) -
//— расход воды за раз -
//— расход удобрения -
//— получится удобрения из куста -
//— необходимый уровень персонажа -
//— дней до плодоношения -
//— номинальное количество плодов в день -
//— длительность плодоношения (дней) -

