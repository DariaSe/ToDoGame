//
//  p_LoginAPIService.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 04.08.2021.
//

import Foundation

protocol LoginAPIService {
    func login(login: String, password: String, completion: @escaping (Bool, String?) -> Void)
    func logout(completion: @escaping (Bool, String?) -> Void)
    func changePassword(oldPassword: String, newPassword: String, completion: @escaping (Bool, String?) -> Void)
}
