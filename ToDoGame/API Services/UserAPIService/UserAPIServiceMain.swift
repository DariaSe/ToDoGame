//
//  UserAPIServiceMain.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 04.08.2021.
//

import Foundation

class UserAPIServiceMain: UserAPIService {
    
    static let shared = UserAPIServiceMain()
    
    private init() {}
    
    var user: User?
    
    func getUser(completion: @escaping (User?, String?) -> Void) {
        
    }
    
    func post(user: User, completion: @escaping (Bool, String?) -> Void) {
        
    }
}
