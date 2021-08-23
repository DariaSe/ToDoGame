//
//  InventoryCollectionReusableView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 23.08.2021.
//

import UIKit

class InventoryCollectionReusableView: UICollectionReusableView {
    
    static let reuseIdentifier = "InventoryHeaderView"
    
    var title: String = "" {
        didSet {
            label.text = title
        }
    }
    
    let label = UILabel()
    let upperStripeView = UIView()
    let lowerStripeView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        label.center(in: self)
        label.font = UIFont(name: nunitoExtraBold, size: 18)!
        label.textColor = UIColor.AppColors.darkGreen
        
        upperStripeView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(upperStripeView)
        upperStripeView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        upperStripeView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -5).isActive = true
        upperStripeView.setDimensions(width: 80, height: 1)
        upperStripeView.backgroundColor = UIColor.AppColors.darkGreen
        
        lowerStripeView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lowerStripeView)
        lowerStripeView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lowerStripeView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5).isActive = true
        lowerStripeView.setDimensions(width: 80, height: 1)
        lowerStripeView.backgroundColor = UIColor.AppColors.darkGreen
    }
}
