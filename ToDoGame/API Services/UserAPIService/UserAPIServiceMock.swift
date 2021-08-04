//
//  UserAPIServiceMock.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 04.08.2021.
//

import Foundation

class UserAPIServiceMock: UserAPIService {
    
    static let shared = UserAPIServiceMock()
    
    private init() {}
    
    var user: User?
    
    func getUser(completion: @escaping (User?, String?) -> Void) {
        let experience = UserDefaultsService.experience
        let gold = UserDefaultsService.gold
        let water = UserDefaultsService.water
        let donationCurrency = UserDefaultsService.donationCurrency
        let fertilizer = UserDefaultsService.fertilizer
        let firewood = UserDefaultsService.firewood
        let user = User(experience: experience, gold: gold, water: water, donationCurrency: donationCurrency, fertilizer: fertilizer, firewood: firewood)
        self.user = user
        completion(user, nil)
    }
    
    func post(user: User, completion: @escaping (Bool, String?) -> Void) {
        completion(true, nil)
    }
}
