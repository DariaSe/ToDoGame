//
//  PlantSpecies.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 30.07.2021.
//

import Foundation

struct PlantSpecies {
    var id: Int
    var title: String
    var description: String
    var buyCostGold: Int
    var buyCostDonation: Int
    var sellCost: Int
    var growthType: PlantGrowthType
    var waterConsumption: Int
    var fertilizerConsumption: Int
    var fertilizerOutput: Int?
    var firewoodOutput: Int?
    var levelRequired: Int
    var daysTilBlooming: Int
    var daysTilHarvest: Int
    var nominalYield: Int
    var fruitingDuration: Int
    
    static let tomato = PlantSpecies(id: 1,
                                     title: Strings.tomato,
                                     description: "",
                                     buyCostGold: 3,
                                     buyCostDonation: 0,
                                     sellCost: 1,
                                     growthType: .bush,
                                     waterConsumption: 2,
                                     fertilizerConsumption: 2,
                                     fertilizerOutput: 2,
                                     levelRequired: 1,
                                     daysTilBlooming: 10,
                                     daysTilHarvest: 12,
                                     nominalYield: 3,
                                     fruitingDuration: 7)
    
    static let strawberry = PlantSpecies(id: 2,
                                         title: Strings.strawberry,
                                         description: "",
                                         buyCostGold: 4,
                                         buyCostDonation: 0,
                                         sellCost: 1,
                                         growthType: .bush,
                                         waterConsumption: 1,
                                         fertilizerConsumption: 1,
                                         fertilizerOutput: 1,
                                         levelRequired: 2,
                                         daysTilBlooming: 6,
                                         daysTilHarvest: 8,
                                         nominalYield: 2,
                                         fruitingDuration: 7)
    
    static let apple = PlantSpecies(id: 3,
                                        title: Strings.apple,
                                        description: "",
                                        buyCostGold: 5,
                                        buyCostDonation: 1,
                                        sellCost: 1,
                                        growthType: .tree,
                                        waterConsumption: 3,
                                        fertilizerConsumption: 3,
                                        firewoodOutput: 20,
                                        levelRequired: 3,
                                        daysTilBlooming: 36,
                                        daysTilHarvest: 40,
                                        nominalYield: 10,
                                        fruitingDuration: 10)
    
    static let sunflower = PlantSpecies(id: 4,
                                        title: Strings.sunflower,
                                        description: "",
                                        buyCostGold: 3,
                                        buyCostDonation: 1,
                                        sellCost: 1,
                                        growthType: .bush,
                                        waterConsumption: 2,
                                        fertilizerConsumption: 2,
                                        fertilizerOutput: 2,
                                        levelRequired: 4,
                                        daysTilBlooming: 14,
                                        daysTilHarvest: 16,
                                        nominalYield: 60,
                                        fruitingDuration: 1)
    
    static let walnut = PlantSpecies(id: 5,
                                     title: Strings.walnut,
                                     description: "",
                                     buyCostGold: 6,
                                     buyCostDonation: 1,
                                     sellCost: 1,
                                     growthType: .tree,
                                     waterConsumption: 4,
                                     fertilizerConsumption: 4,
                                     firewoodOutput: 24,
                                     levelRequired: 5,
                                     daysTilBlooming: 40,
                                     daysTilHarvest: 45,
                                     nominalYield: 7,
                                     fruitingDuration: 24)
    
    static let watermelon = PlantSpecies(id: 6,
                                         title: Strings.watermelon,
                                         description: "",
                                         buyCostGold: 6,
                                         buyCostDonation: 1,
                                         sellCost: 1,
                                         growthType: .bush,
                                         waterConsumption: 3,
                                         fertilizerConsumption: 3,
                                         fertilizerOutput: 2,
                                         levelRequired: 6,
                                         daysTilBlooming: 16,
                                         daysTilHarvest: 18,
                                         nominalYield: 1,
                                         fruitingDuration: 3)
    
    static let cherry = PlantSpecies(id: 7,
                                     title: Strings.cherry,
                                     description: "",
                                     buyCostGold: 6,
                                     buyCostDonation: 1,
                                     sellCost: 1,
                                     growthType: .tree,
                                     waterConsumption: 4,
                                     fertilizerConsumption: 4,
                                     firewoodOutput: 18,
                                     levelRequired: 7,
                                     daysTilBlooming: 30,
                                     daysTilHarvest: 34,
                                     nominalYield: 25,
                                     fruitingDuration: 7)
    
    static let pineapple = PlantSpecies(id: 8,
                                        title: Strings.pineapple,
                                        description: "",
                                        buyCostGold: 7,
                                        buyCostDonation: 1,
                                        sellCost: 1,
                                        growthType: .bush,
                                        waterConsumption: 2,
                                        fertilizerConsumption: 2,
                                        fertilizerOutput: 2,
                                        levelRequired: 8,
                                        daysTilBlooming: 14,
                                        daysTilHarvest: 17,
                                        nominalYield: 1,
                                        fruitingDuration: 4)
    
    static let avocado = PlantSpecies(id: 9,
                                      title: Strings.avocado,
                                      description: "",
                                      buyCostGold: 8,
                                      buyCostDonation: 1,
                                      sellCost: 2,
                                      growthType: .tree,
                                      waterConsumption: 4,
                                      fertilizerConsumption: 4,
                                      firewoodOutput: 22,
                                      levelRequired: 8,
                                      daysTilBlooming: 37,
                                      daysTilHarvest: 42,
                                      nominalYield: 6,
                                      fruitingDuration: 9)
    
    static let coconut = PlantSpecies(id: 10,
                                      title: Strings.coconut,
                                      description: "",
                                      buyCostGold: 8,
                                      buyCostDonation: 2,
                                      sellCost: 2,
                                      growthType: .tree,
                                      waterConsumption: 5,
                                      fertilizerConsumption: 5,
                                      firewoodOutput: 26,
                                      levelRequired: 9,
                                      daysTilBlooming: 42,
                                      daysTilHarvest: 46,
                                      nominalYield: 7,
                                      fruitingDuration: 8)
    
    static let chiliPepper = PlantSpecies(id: 11,
                                          title: Strings.chiliPepper,
                                          description: "",
                                          buyCostGold: 7,
                                          buyCostDonation: 2,
                                          sellCost: 1,
                                          growthType: .bush,
                                          waterConsumption: 2,
                                          fertilizerConsumption: 2,
                                          fertilizerOutput: 2,
                                          levelRequired: 9,
                                          daysTilBlooming: 14,
                                          daysTilHarvest: 17,
                                          nominalYield: 3,
                                          fruitingDuration: 5)
    
    static let dragonfruit = PlantSpecies(id: 12,
                                          title: Strings.dragonfruit,
                                          description: "",
                                          buyCostGold: 10,
                                          buyCostDonation: 2,
                                          sellCost: 2,
                                          growthType: .bush,
                                          waterConsumption: 3,
                                          fertilizerConsumption: 3,
                                          fertilizerOutput: 3,
                                          levelRequired: 10,
                                          daysTilBlooming: 20,
                                          daysTilHarvest: 22,
                                          nominalYield: 4,
                                          fruitingDuration: 6)
    
    static let plants: [PlantSpecies] = [.tomato, .strawberry, .apple, .sunflower, .walnut, .watermelon, .cherry, .pineapple, .avocado, .coconut, .chiliPepper, .dragonfruit]
}

enum PlantGrowthType: Int {
    case bush
    case tree
}

enum PlantType: Int {
    case tomato
    case strawberry
    case apple
    case sunflower
    case walnut
    case watermelon
    case cherry
    case pineapple
    case avocado
    case coconut
    case chiliPepper
    case dragonfruit
    
    case firePlant
    case waterPlant
    case airPlant
    case earthPlant
    case humanPlant
    case invisibilityPlant
    case teleportationPlant
    case portalPlant
}
