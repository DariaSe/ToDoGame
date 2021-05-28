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
    
    static var selectedTags: [Int] {
        get { defaults.object(forKey: selectedTagsKey) as? [Int] ?? [Int]() }
        set(newValue) { defaults.set(newValue, forKey: selectedTagsKey)} }
    
    // MARK: - Keys
    
    static let selectedTagsKey = "selectedTags"
    
    // MARK: - Setting default values
    
    static func setDefault() {
        if defaults.value(forKey: selectedTagsKey) == nil {
            defaults.set([Int](), forKey: selectedTagsKey)
        }
    }
}
