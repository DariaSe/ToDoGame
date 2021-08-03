//
//  UserDefaultsService.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 25.05.2021.
//

import Foundation

class UserDefaultsService {
    
    static let defaults = UserDefaults.standard
    
    // MARK: - Values
    
    static var lastColor: Int {
        get { defaults.integer(forKey: lastColorKey) }
        set(newValue) { defaults.set(newValue, forKey: lastColorKey)} }
    
    static var experience: Int {
        get { defaults.integer(forKey: experienceKey) }
        set(newValue) { defaults.set(newValue, forKey: experienceKey)} }
    
    static var water: Int {
        get { defaults.integer(forKey: waterKey) }
        set(newValue) { defaults.set(newValue, forKey: waterKey)} }
    
    static var waterCapacity: Int {
        get { defaults.integer(forKey: waterCapacityKey) }
        set(newValue) { defaults.set(newValue, forKey: waterCapacityKey) } }
    
    static var gold: Int {
        get { defaults.integer(forKey: goldKey) }
        set(newValue) { defaults.set(newValue, forKey: goldKey)} }
    
    static var fertilizer: Int {
        get { defaults.integer(forKey: fertilizerKey) }
        set(newValue) { defaults.set(newValue, forKey: fertilizerKey) } }
    
    static var firewood: Int {
        get { defaults.integer(forKey: firewoodKey) }
        set(newValue) { defaults.set(newValue, forKey: firewoodKey) } }
    
    static var donationBalls: Int {
        get { defaults.integer(forKey: donationBallsKey) }
        set(newValue) { defaults.set(newValue, forKey: donationBallsKey) } }

    
    // MARK: - Keys

    static let lastColorKey = "lastColor"
    static let experienceKey = "experience"
    static let waterKey = "water"
    static let waterCapacityKey = "waterCapacity"
    static let goldKey = "gold"
    static let fertilizerKey = "fertilizer"
    static let firewoodKey = "firewood"
    static let donationBallsKey = "donationBalls"
    
    // MARK: - Setting default values
    
    static func setDefault() {
        
        if defaults.value(forKey: lastColorKey) == nil {
            defaults.set(0, forKey: lastColorKey)
        }
        if defaults.value(forKey: experienceKey) == nil {
            defaults.set(0, forKey: experienceKey)
        }
        if defaults.value(forKey: waterKey) == nil {
            defaults.set(0, forKey: waterKey)
        }
        if defaults.value(forKey: waterCapacityKey) == nil {
            defaults.set(10, forKey: waterCapacityKey)
        }
        if defaults.value(forKey: goldKey) == nil {
            defaults.set(0, forKey: goldKey)
        }
        if defaults.value(forKey: firewoodKey) == nil {
            defaults.set(0, forKey: firewoodKey)
        }
        if defaults.value(forKey: donationBallsKey) == nil {
            defaults.set(0, forKey: donationBallsKey)
        }
    }
}
