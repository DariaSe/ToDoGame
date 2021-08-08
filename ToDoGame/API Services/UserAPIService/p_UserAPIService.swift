//
//  p_UserAPIService.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 04.08.2021.
//

import Foundation

protocol UserAPIService {
    func getUser(completion: @escaping (User?, String?) -> Void)
    func save(user: User, completion: @escaping (Bool, String?) -> Void)
}
