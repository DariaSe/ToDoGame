//
//  GamificationOverviewView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 04.07.2021.
//

import UIKit

class GamificationOverviewView: UIView {
    
    let experienceLabel = UILabel()
    let coinImageView = UIImageView()
    let goldLabel = UILabel()
    
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
        coinImageView.trailingAnchor.constraint(equalTo: goldLabel.leadingAnchor, constant: -10).isActive = true
        coinImageView.setDimensions(width: 30, height: 30)
        experienceLabel.textColor = UIColor.textColor
        experienceLabel.font = UIFont.normalTextFont
        experienceLabel.textAlignment = .left
        goldLabel.textColor = UIColor.textColor
        goldLabel.font = UIFont.normalTextFont
        goldLabel.textAlignment = .right
        coinImageView.image = coinImage
    }
    
    func setup(level: Int, currentExp: Int, nextLevelExp: Int, gold: Int) {
        experienceLabel.text = Strings.level + " " + level.string + ": " + currentExp.string + "/" + nextLevelExp.string
        goldLabel.text = gold.string
    }
}
