//
//  RecipeCollectionViewCell.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 23.08.2021.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "RecipeCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        
    }
    
    func update(with recipe: PotionRecipe) {
        
    }
}
