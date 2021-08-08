//
//  User.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 04.08.2021.
//

import Foundation

struct User: Codable {
    var experience: Int
    var gold: Int
    var water: Int
    var waterCapacity: Int
    var donationCurrency: Int
    var fertilizer: Int
    var firewood: Int
    var oil: Int
    
    static let zero = User(experience: 0, gold: 0, water: 0, waterCapacity: 10, donationCurrency: 0, fertilizer: 0, firewood: 0, oil: 0)
    
    var dictionary: [String : Any] {
        var dict = [String : Int]()
        dict["experience"] = experience
        dict["gold"] = gold
        dict["water"] = water
        dict["waterCapacity"] = waterCapacity
        dict["donationCurrency"] = donationCurrency
        dict["fertilizer"] = fertilizer
        dict["firewood"] = firewood
        dict["oil"] = oil
        return dict
    }
    
    static func initialize(from dictionary: [String : Any]) -> User? {
        guard let experience = dictionary["experience"] as? Int,
              let gold = dictionary["gold"] as? Int,
              let water = dictionary["water"] as? Int,
              let waterCapacity = dictionary["waterCapacity"] as? Int,
              let donationCurrency = dictionary["donationCurrency"] as? Int,
              let fertilizer = dictionary["fertilizer"] as? Int,
              let firewood = dictionary["firewood"] as? Int,
              let oil = dictionary["oil"] as? Int else { return nil }
        return User(experience: experience, gold: gold, water: water, waterCapacity: waterCapacity, donationCurrency: donationCurrency, fertilizer: fertilizer, firewood: firewood, oil: oil)
    }
    
    //MARK: Decoding and encoding
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("user").appendingPathExtension("plist")
    
    static func saveToFile(user: User) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedUser = try? propertyListEncoder.encode(user)
        try? encodedUser?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> User? {
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedUserData = try? Data(contentsOf: archiveURL) else { return nil }
        return try? propertyListDecoder.decode(User.self, from: retrievedUserData)
    }
}
