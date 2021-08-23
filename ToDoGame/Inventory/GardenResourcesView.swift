//
//  GardenResourcesView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 23.08.2021.
//

import UIKit

class GardenResourcesView: UIView {
    
    let waterImageView = UIImageView()
    let waterLabel = UILabel()
    
    let fertilizerImageView = UIImageView()
    let fertilizerLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToLayoutMargins(subview: fertilizerLabel, leading: nil,top: nil, bottom: nil)
        fertilizerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        fertilizerLabel.textColor = UIColor.AppColors.darkGreen
        fertilizerLabel.font = UIFont(name: nunitoRegular, size: 18)
        fertilizerLabel.textAlignment = .right
        
        self.addSubview(fertilizerImageView)
        fertilizerImageView.translatesAutoresizingMaskIntoConstraints = false
        fertilizerImageView.centerYAnchor.constraint(equalTo: fertilizerLabel.centerYAnchor).isActive = true
        fertilizerImageView.trailingAnchor.constraint(equalTo: fertilizerLabel.leadingAnchor, constant: -7).isActive = true
        fertilizerImageView.setDimensions(width: 32, height: 32)
        fertilizerImageView.image = UIImage(named: "Fertilizer")
        
        waterLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(waterLabel)
        waterLabel.trailingAnchor.constraint(equalTo: fertilizerImageView.leadingAnchor, constant: -40).isActive = true
        waterLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        waterLabel.textColor = UIColor.AppColors.darkGreen
        waterLabel.font = UIFont(name: nunitoRegular, size: 18)
        waterLabel.textAlignment = .right
        
        self.addSubview(waterImageView)
        waterImageView.translatesAutoresizingMaskIntoConstraints = false
        waterImageView.centerYAnchor.constraint(equalTo: waterLabel.centerYAnchor).isActive = true
        waterImageView.trailingAnchor.constraint(equalTo: waterLabel.leadingAnchor, constant: -7).isActive = true
        waterImageView.setDimensions(width: 32, height: 32)
        waterImageView.image = UIImage(named: "Water")
    }
    
    func updateUI() {
        let user = UserService.shared.user
        waterLabel.text = user.water.string + "/" + user.waterCapacity.string
        fertilizerLabel.text = user.fertilizer.string
    }
}
