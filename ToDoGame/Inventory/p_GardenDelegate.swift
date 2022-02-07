//
//  p_GardenDelegate.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 08.12.2021.
//

import Foundation

protocol GardenDelegate {
    
    func water(plantID: Int)
    func fertilize(plantID: Int)
    func pickFruits(plantID: Int)
    func delete(plantID: Int)
    
}
