//
//  GamificationOverviewView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 04.07.2021.
//

import UIKit

class GamificationOverviewView: UIView {
    
    let levelLabel = UILabel()
    let experienceLabel = UILabel()
    let experienceProgressView = UIProgressView()
    
    let waterImageView = UIImageView()
    let waterLabel = UILabel()
    
    let waterImage = UIImage(named: "Water")
    let coinImage = UIImage(named: "Coin")

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToLayoutMargins(subview: levelLabel, trailing: nil, bottom: nil)
        
        self.pinToLayoutMargins(subview: experienceProgressView, trailing: nil, top: nil)
        levelLabel.bottomAnchor.constraint(equalTo: experienceProgressView.topAnchor, constant: -5).isActive = true
        experienceProgressView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        experienceProgressView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        
        experienceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(experienceLabel)
        experienceLabel.trailingAnchor.constraint(equalTo: experienceProgressView.trailingAnchor).isActive = true
        experienceLabel.bottomAnchor.constraint(equalTo: experienceProgressView.topAnchor, constant: -5).isActive = true
        
        self.pinToLayoutMargins(subview: waterLabel, leading: nil,top: nil, bottom: nil)
        waterLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.addSubview(waterImageView)
        waterImageView.translatesAutoresizingMaskIntoConstraints = false
        waterImageView.centerYAnchor.constraint(equalTo: waterLabel.centerYAnchor).isActive = true
        waterImageView.trailingAnchor.constraint(equalTo: waterLabel.leadingAnchor, constant: -7).isActive = true
        waterImageView.setDimensions(width: 25, height: 25)
        
        levelLabel.textColor = UIColor.AppColors.darkGreen
        levelLabel.font = UIFont(name: nunitoBold, size: 18)!
        
        experienceLabel.textColor = UIColor.AppColors.darkGreen
        experienceLabel.font = UIFont.normalTextFont
        experienceLabel.textAlignment = .right
        
        experienceProgressView.progressTintColor = UIColor.AppColors.mint
        experienceProgressView.trackTintColor = UIColor.backgroundColor
        experienceProgressView.layer.cornerRadius = 4
        
        waterLabel.textColor = UIColor.AppColors.darkGreen
        waterLabel.font = UIFont.normalTextFont
        waterLabel.textAlignment = .right
        waterImageView.image = waterImage
    }
    
    func setup(level: Int, currentExp: Int, nextLevelExp: Int, water: Int, maxWater: Int, gold: Int) {
        levelLabel.text = Strings.level + " " + level.string + ": "
        experienceLabel.text = currentExp.string + "/" + nextLevelExp.string
        experienceProgressView.progress = Float(currentExp) / Float(nextLevelExp)
        waterLabel.text = water.string  + "/" + maxWater.string
    }
}
