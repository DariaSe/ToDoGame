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
    var age: Int { return wateringDates.count + fertilizerDates.count - timesRestored }
    var plantingDate: Date?
    var wateringDates: [Date] = []
    var fertilizerDates: [Date] = []
    var harvestDates: [Date] = []
    var timesRestored: Int = 0
    var isHibernated: Bool = false
    var state: PlantState {
        guard plantingDate != nil else { return .seed }
        guard !wateringDates.isEmpty else { return .seed }
        guard !isHibernated else { return .hibernated }
        let daysSinceWatering = Calendar.current.dateComponents([.day], from: wateringDates.last!.dayStart, to: Date().dayStart).day ?? 0
        switch daysSinceWatering {
        case 4...6: return .withering
        case 7...Int.max : return .dead
        default: break
        }
        switch age {
        case 0: return .seed
        case 1, 2: return .sprout
        case 3..<species.daysTilBlooming: return .growing
        case species.daysTilBlooming..<species.daysTilFruiting: return .blooming
        case species.daysTilFruiting..<species.maxAge: return .fruiting
        case species.maxAge...Int.max: return .dead
        default: break
        }
        return .unknown
    }
    var stateDescription: String {
        switch state {
        case .seed, .sprout, .growing, .blooming:
            let daysRemaining = species.daysTilFruiting - age
            return daysRemaining.string + " " + Strings.daysCount.localizedForCount(daysRemaining) + Strings.untilFruiting
            
        case .fruiting:
            let daysRemaining = species.maxAge - age
            return daysRemaining.string + " " + Strings.daysCount.localizedForCount(daysRemaining) + Strings.remaining
        default: return ""
        }
    }
    var magic: Magic?
    var specialAttribute: SpecialAttribute?
    
   
    static let sampleTwo = Plant(species: .strawberry,
                                 instanceID: 2, imageURL: "",
                                 plantingDate: Date().dayStart.addingTimeInterval(-(Date.oneDay * 5)),
                                 wateringDates: [Date().dayStart.addingTimeInterval(-(Date.oneDay * 5)),
                                                 Date().dayStart.addingTimeInterval(-(Date.oneDay * 4)),
                                                 Date().dayStart.addingTimeInterval(-(Date.oneDay)),
                                                 Date()],
                                 fertilizerDates: [Date().dayStart.addingTimeInterval(-(Date.oneDay * 5)),
                                                   Date().dayStart.addingTimeInterval(-(Date.oneDay * 4)),
                                                   Date().dayStart.addingTimeInterval(-(Date.oneDay)),
                                                   Date().dayStart],
                                 magic: nil, specialAttribute: nil)
    
    static let sampleThree = Plant(species: .chiliPepper,
                                   instanceID: 3, imageURL: "",
                                   plantingDate: Date().dayStart.addingTimeInterval(-(Date.oneDay * 7)),
                                   wateringDates: [Date().dayStart.addingTimeInterval(-(Date.oneDay * 7)),
                                                   Date().dayStart.addingTimeInterval(-(Date.oneDay * 6)),
                                                   Date().dayStart.addingTimeInterval(-(Date.oneDay * 5))],
                                   fertilizerDates: [Date().dayStart.addingTimeInterval(-(Date.oneDay * 5))],
                                   magic: nil, specialAttribute: nil)
    
    static let sample = [Plant.sampleTwo, Plant.sampleThree]
}

enum PlantState: String {
    case seed
    case sprout
    case growing
    case blooming
    case fruiting
    case withering
    case dead
    case hibernated
    case unknown
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
