//
//  InventoryItemCollectionViewCell.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 23.08.2021.
//

import UIKit

class InventoryItemCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "InventoryItemCell"
    
    let shadowView = UIView()
    let upperView = UIView()
    let stackView = UIStackView()
    let imageWithCount = CountedImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        contentView.pinToEdges(subview: shadowView, leading: 3, trailing: 3, top: 3, bottom: 3)
        shadowView.layer.shadowRadius = 5
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 1)
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.pinToEdges(subview: upperView)
        upperView.layer.cornerRadius = 20
        upperView.backgroundColor = UIColor.backgroundColor
        stackView.center(in: contentView)
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.axis = .vertical
        stackView.addArrangedSubview(imageWithCount)
        stackView.addArrangedSubview(label)
        let cellWidth = (UIScreen.main.bounds.width - 20) / 3 - 1
        let imageWidth = cellWidth * 0.5
        imageWithCount.setDimensions(width: imageWidth, height: imageWidth)
        label.textColor = UIColor.AppColors.darkGreen
        label.font = UIFont(name: nunitoBold, size: 16)!
    }
    
    func update(with item: InventoryItem) {
        imageWithCount.image = UIImage(named: "Seed placeholder")
        imageWithCount.count = item.quantity
        label.text = item.title
    }
}
