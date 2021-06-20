//
//  ColorCollectionViewCell.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 20.06.2021.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ColorCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        contentView.layer.cornerRadius = 10
    }
    
    func update(with color: UIColor) {
        contentView.backgroundColor = color
    }
}
