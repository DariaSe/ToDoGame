//
//  UserAPIServiceMock.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 04.08.2021.
//

import Foundation

class UserAPIServiceMock: UserAPIService {
    
    func getUser(completion: @escaping (User?, String?) -> Void) {
        let user = User.loadFromFile()
        completion(user, nil)
    }
    
    func save(user: User, completion: @escaping (Bool, String?) -> Void) {
        completion(true, nil)
    }
}
