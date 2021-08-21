//
//  BuffAPIServiceMock.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 06.08.2021.
//

import Foundation

class BuffAPIServiceMock: BuffAPIService {
    
    func apply(buffPotion: BuffPotion, completion: @escaping (Bool, String?) -> Void) {
        completion(true, nil)
    }
    
    func getActiveBuffPotion(completion: @escaping (BuffPotion?, String?) -> Void) {
        completion(BuffPotion(title: "Gold", imageName: "", applicationDate: Date()), nil)
    }
}
