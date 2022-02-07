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
    
    let waterImage = UIImage(named: "Watering_horizontal")
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
        let width = UIScreen.main.bounds.width / 2 - self.layoutMargins.left * 2
        experienceProgressView.widthAnchor.constraint(equalToConstant: width).isActive = true
        experienceProgressView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        
        experienceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(experienceLabel)
        experienceLabel.leadingAnchor.constraint(equalTo: levelLabel.trailingAnchor, constant: 5).isActive = true
        experienceLabel.centerYAnchor.constraint(equalTo: levelLabel.centerYAnchor).isActive = true
        
        self.pinToLayoutMargins(subview: waterImageView, leading: nil, trailing: 10, top: nil, bottom: nil)
        waterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        waterImageView.setDimensions(width: 100, height: 60)
        
        self.pinToLayoutMargins(subview: waterLabel, leading: nil, trailing: 0, top: nil, bottom: nil)
        waterLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        levelLabel.textColor = UIColor.textColor
        levelLabel.font = UIFont(name: nunitoBold, size: 18)!
        
        experienceLabel.textColor = UIColor.textColor
        experienceLabel.font = UIFont.normalTextFont
        experienceLabel.textAlignment = .right
        
        experienceProgressView.progressTintColor = UIColor.AppColors.mint
        experienceProgressView.trackTintColor = UIColor.white.withAlphaComponent(0.6)
        experienceProgressView.layer.cornerRadius = 4
        
        waterLabel.textColor = UIColor.textColor
        waterLabel.font = UIFont(name: nunitoRegular, size: 18)!
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
