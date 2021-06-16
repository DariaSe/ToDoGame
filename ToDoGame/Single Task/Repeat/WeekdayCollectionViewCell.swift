//
//  WeekdayCollectionViewCell.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 16.06.2021.
//

import UIKit

class WeekdayCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "WeekdayCell"
    
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
        contentView.pinToEdges(subview: containerView)
        label.center(in: containerView)
        containerView.layer.cornerRadius = 10
        label.font = UIFont(name: nunitoSemiBold, size: 12)
        containerView.layer.borderColor = UIColor.borderColor.cgColor
    }
    
    func update(with text: String, isSelected: Bool) {
        label.text = text
        if isSelected {
            containerView.layer.borderWidth = 1.0
            containerView.backgroundColor = UIColor.gray
            label.textColor = UIColor.white
        }
        else {
            containerView.layer.borderWidth = 0.0
            containerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
            label.textColor = UIColor.textColor
        }
    }
}
