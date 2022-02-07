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
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let countLabel = UILabel()
    
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
        contentView.pinToEdges(subview: imageView, leading: 3, trailing: 3, top: 3, bottom: 3)
        contentView.pinToEdges(subview: titleLabel, leading: 10, trailing: 10, top: 20, bottom: nil)
        titleLabel.textAlignment = .center
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        titleLabel.textColor = UIColor.white.withAlphaComponent(0.6)
        titleLabel.font = UIFont(name: nunitoExtraBold, size: 12)!
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(countLabel)
        countLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        countLabel.textAlignment = .center
        countLabel.textColor = UIColor.white.withAlphaComponent(0.6)
        countLabel.font = UIFont(name: nunitoBold, size: 12)
    }
    
    func update(with item: InventoryItem) {
        imageView.image = UIImage(named: item.imageName + "_large") ?? UIImage(named: item.imageName)
        titleLabel.text = item.title.uppercased()
        countLabel.text = "x" + item.quantity.string
    }
}
