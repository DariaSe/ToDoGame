//
//  GamificationOverviewView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 04.07.2021.
//

import UIKit

class GamificationOverviewView: UIView {
    
    let experienceLabel = UILabel()
    let waterImageView = UIImageView()
    let waterLabel = UILabel()
    let coinImageView = UIImageView()
    let goldLabel = UILabel()
    
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
        self.pinToLayoutMargins(subview: experienceLabel, trailing: nil)
        self.pinToLayoutMargins(subview: goldLabel, leading: nil)
        self.addSubview(coinImageView)
        coinImageView.translatesAutoresizingMaskIntoConstraints = false
        coinImageView.centerYAnchor.constraint(equalTo: goldLabel.centerYAnchor).isActive = true
        coinImageView.trailingAnchor.constraint(equalTo: goldLabel.leadingAnchor, constant: -7).isActive = true
        coinImageView.setDimensions(width: 30, height: 30)
        self.addSubview(waterLabel)
        waterLabel.translatesAutoresizingMaskIntoConstraints = false
        waterLabel.centerYAnchor.constraint(equalTo: coinImageView.centerYAnchor).isActive = true
        waterLabel.trailingAnchor.constraint(equalTo: coinImageView.leadingAnchor, constant: -15).isActive = true
        self.addSubview(waterImageView)
        waterImageView.translatesAutoresizingMaskIntoConstraints = false
        waterImageView.centerYAnchor.constraint(equalTo: waterLabel.centerYAnchor).isActive = true
        waterImageView.trailingAnchor.constraint(equalTo: waterLabel.leadingAnchor, constant: -7).isActive = true
        waterImageView.setDimensions(width: 25, height: 25)
        experienceLabel.textColor = UIColor.textColor
        experienceLabel.font = UIFont.normalTextFont
        experienceLabel.textAlignment = .left
        
        waterLabel.textColor = UIColor.textColor
        waterLabel.font = UIFont.normalTextFont
        waterLabel.textAlignment = .left
        waterImageView.image = waterImage
        
        goldLabel.textColor = UIColor.textColor
        goldLabel.font = UIFont.normalTextFont
        goldLabel.textAlignment = .left
        coinImageView.image = coinImage
    }
    
    func setup(level: Int, currentExp: Int, nextLevelExp: Int, water: Int, gold: Int) {
        experienceLabel.text = Strings.level + " " + level.string + ": " + currentExp.string + "/" + nextLevelExp.string
        waterLabel.text = water.string
        goldLabel.text = gold.string
    }
}
