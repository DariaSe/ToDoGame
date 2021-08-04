//
//  User.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 04.08.2021.
//

import Foundation

struct User {
    var experience: Int
    var gold: Int
    var water: Int
    var donationCurrency: Int
    var fertilizer: Int
    var firewood: Int
    
    var dictionary: [String : Any] {
        var dict = [String : Int]()
        dict["experience"] = experience
        dict["gold"] = gold
        dict["water"] = water
        dict["donationCurrency"] = donationCurrency
        dict["fertilizer"] = fertilizer
        dict["firewood"] = firewood
        return dict
    }
    
    static func initialize(from dictionary: [String : Any]) -> User? {
        guard let experience = dictionary["experience"] as? Int,
              let gold = dictionary["gold"] as? Int,
              let water = dictionary["water"] as? Int,
              let donationCurrency = dictionary["donationCurrency"] as? Int,
              let fertilizer = dictionary["fertilizer"] as? Int,
              let firewood = dictionary["firewood"] as? Int else { return nil }
        return User(experience: experience, gold: gold, water: water, donationCurrency: donationCurrency, fertilizer: fertilizer, firewood: firewood)
    }
}
