//
//  TagCollectionViewCell.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 20.05.2021.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "TagCell"
    
    let containerView = UIView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup() {
        contentView.setConstraints(on: containerView, margins: false, leading: 2, trailing: 2, top: 7, bottom: 8)
        containerView.setConstraints(on: label, margins: false, leading: 12, trailing: 12, top: nil, bottom: nil)
        label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        containerView.layer.cornerRadius = 10
        containerView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        label.textColor = UIColor.white.withAlphaComponent(0.8)
    }
    
    func update(with tag: Tag, isSelected: Bool) {
        label.text = tag.title
        if isSelected {
            containerView.layer.borderWidth = 3.0
            containerView.layer.borderColor = UIColor.red.cgColor
        }
        else {
            containerView.layer.borderWidth = 1.0
            containerView.layer.borderColor = UIColor.borderColor.cgColor
        }
        containerView.backgroundColor = UIColor.tagColor(index: tag.color)
    }
}
