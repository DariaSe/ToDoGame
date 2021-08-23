//
//  p_InventoryItem.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 23.08.2021.
//

import Foundation

protocol InventoryItem {
    var title: String { get }
    var imageName: String { get }
    var quantity: Int { get set }
}
