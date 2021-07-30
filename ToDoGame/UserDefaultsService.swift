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
    
    static var gold: Int {
        get { defaults.integer(forKey: goldKey) }
        set(newValue) { defaults.set(newValue, forKey: goldKey)} }

    
    // MARK: - Keys

    static let lastColorKey = "lastColor"
    static let experienceKey = "experience"
    static let waterKey = "water"
    static let goldKey = "gold"
    
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
        if defaults.value(forKey: goldKey) == nil {
            defaults.set(0, forKey: goldKey)
        }
    }
}
