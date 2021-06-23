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
    
    // MARK: - Keys
    
    static let lastColorKey = "lastColor"
    
    // MARK: - Setting default values
    
    static func setDefault() {
        if defaults.value(forKey: lastColorKey) == nil {
            defaults.set(0, forKey: lastColorKey)
        }
    }
}
