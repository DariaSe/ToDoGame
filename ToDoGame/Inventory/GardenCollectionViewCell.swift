//
//  GardenCollectionViewCell.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 02.08.2021.
//

import UIKit

class GardenCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "GardenCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        
    }
    
    func update(with plant: Plant) {
        
    }
}
