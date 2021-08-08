//
//  p_BuffAPIService.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 06.08.2021.
//

import Foundation

protocol BuffAPIService {
    func apply(buffPotion: BuffPotion, completion: @escaping (Bool, String?) -> Void)
    func getActiveBuffPotion(completion: @escaping (BuffPotion?, String?) -> Void)
}
