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
        self.pinToLayoutMargins(subview: fertilizerImageView, leading: nil,top: nil, bottom: nil)
        fertilizerImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        fertilizerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(fertilizerLabel)
        fertilizerLabel.centerYAnchor.constraint(equalTo: fertilizerImageView.centerYAnchor).isActive = true
        fertilizerLabel.trailingAnchor.constraint(equalTo: fertilizerImageView.trailingAnchor, constant: -10).isActive = true
        fertilizerImageView.setDimensions(width: 80, height: 48)
        fertilizerImageView.image = UIImage(named: "Fertilizer_horizontal")
        
        fertilizerLabel.textColor = UIColor.textColor
        fertilizerLabel.font = UIFont(name: nunitoRegular, size: 18)!
        fertilizerLabel.textAlignment = .right
        
        self.pinToLayoutMargins(subview: waterImageView, trailing: nil, top: nil, bottom: nil)
        waterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        waterImageView.setDimensions(width: 100, height: 60)
        waterImageView.image = UIImage(named: "Watering_horizontal")
        
        waterLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(waterLabel)
        waterLabel.leadingAnchor.constraint(equalTo: waterImageView.trailingAnchor, constant: -10).isActive = true
        waterLabel.centerYAnchor.constraint(equalTo: waterImageView.centerYAnchor).isActive = true
        waterLabel.textColor = UIColor.textColor
        waterLabel.font = UIFont(name: nunitoRegular, size: 18)!
        waterLabel.textAlignment = .right
    }
    
    func updateUI() {
        let user = UserService.shared.user
        waterLabel.text = user.water.string + "/" + user.waterCapacity.string
        fertilizerLabel.text = user.fertilizer.string
    }
}
