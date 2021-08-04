//
//  BuyAlertView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 03.08.2021.
//

import UIKit

class BuyAlertView: UIView {
    
    var width: CGFloat = 240
    
    let alertView = UIView()
    let buyLabel = UILabel()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let levelRequiredLabel = UILabel()
    
    let buyGoldButton = UIButton()
    let buyDonationButton = UIButton()
    let goldStackView = UIStackView()
    let goldImageView = UIImageView()
    let goldLabel = UILabel()
    let donationStackView = UIStackView()
    let donationImageView = UIImageView()
    let donationLabel = UILabel()
    
    var buyGoldWidthConstraint = NSLayoutConstraint()
    var buyDonationWidthConstraint = NSLayoutConstraint()
    
    var didBuyGold: (() -> ())?
    var didBuyDonation: (() -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToEdges(subview: alertView)
        alertView.clipsToBounds = true
        alertView.backgroundColor = .white
        alertView.layer.cornerRadius = 20
        alertView.layer.borderWidth = 1.0
        alertView.layer.borderColor = UIColor.borderColor.cgColor
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: alertView.centerYAnchor, constant: -40).isActive = true
        imageView.setDimensions(width: 100, height: 100)
        
        buyLabel.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(buyLabel)
        buyLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        buyLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -15).isActive = true
        buyLabel.textColor = UIColor.textColor
        buyLabel.textAlignment = .center
        buyLabel.text = Strings.buy
        buyLabel.font = UIFont.buttonFont
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.font = UIFont.normalTextFont
        titleLabel.textColor = UIColor.textColor
        
        levelRequiredLabel.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(levelRequiredLabel)
        levelRequiredLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        levelRequiredLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        levelRequiredLabel.textAlignment = .center
        levelRequiredLabel.font = UIFont.buttonFont
        levelRequiredLabel.textColor = UIColor.textColor
        
        alertView.pinToEdges(subview: buyDonationButton, trailing: nil, top: nil)
        buyDonationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buyDonationWidthConstraint = buyDonationButton.widthAnchor.constraint(equalToConstant: width / 2)
        buyDonationWidthConstraint.isActive = true
        buyDonationButton.layer.borderWidth = 1.0
        buyDonationButton.layer.borderColor = UIColor.borderColor.cgColor
        buyDonationButton.clipsToBounds = true
        buyDonationButton.backgroundColor = UIColor.backgroundColor
        donationStackView.center(in: buyDonationButton)
        donationStackView.axis = .horizontal
        donationStackView.alignment = .center
        donationStackView.spacing = 5
        donationStackView.addArrangedSubview(donationImageView)
        donationStackView.addArrangedSubview(donationLabel)
        donationImageView.setDimensions(width: 24, height: 24)
        donationImageView.image = UIImage(named: "Crystal ball")
        donationLabel.font = UIFont.normalTextFont
        donationLabel.textColor = UIColor.textColor
        buyDonationButton.addTarget(self, action: #selector(buyDonation), for: .touchUpInside)
        
        alertView.pinToEdges(subview: buyGoldButton, leading: nil, top: nil)
        buyGoldButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buyGoldWidthConstraint = buyGoldButton.widthAnchor.constraint(equalToConstant: width / 2)
        buyGoldWidthConstraint.isActive = true
        buyGoldButton.layer.borderWidth = 1.0
        buyGoldButton.layer.borderColor = UIColor.borderColor.cgColor
        buyGoldButton.clipsToBounds = true
        buyGoldButton.backgroundColor = UIColor.backgroundColor
        goldStackView.center(in: buyGoldButton)
        goldStackView.axis = .horizontal
        goldStackView.alignment = .center
        goldStackView.spacing = 5
        goldStackView.addArrangedSubview(goldImageView)
        goldStackView.addArrangedSubview(goldLabel)
        goldImageView.setDimensions(width: 24, height: 24)
        goldImageView.image = UIImage(named: "Coin")
        goldLabel.font = UIFont.normalTextFont
        goldLabel.textColor = UIColor.textColor
        buyGoldButton.addTarget(self, action: #selector(buyGold), for: .touchUpInside)
    }
    
    @objc func buyGold() {
        buyGoldButton.animateScale(duration: 0.1, scale: 1.1)
        didBuyGold?()
    }
    
    @objc func buyDonation() {
        buyDonationButton.animateScale(duration: 0.1, scale: 1.1)
        didBuyDonation?()
    }
    
    func update(with item: ShopItem) {
        titleLabel.text = item.title
        imageView.image = UIImage(named: "Seed placeholder")
        let levelRequired = item.levelRequired
        levelRequiredLabel.text = Strings.requiredLevel + levelRequired.string
        donationLabel.text = item.buyCostDonation.string
        goldLabel.text = item.buyCostGold.string
        let currentLevel = LevelManager.currentLevel
        let gold = UserDefaultsService.gold
        let donationBalls = UserDefaultsService.donationCurrency
        if currentLevel < levelRequired {
            buyLabel.isHidden = true
            levelRequiredLabel.textColor = UIColor.destructiveColor
            buyDonationButton.isEnabled = false
            buyDonationButton.alpha = 0.4
            buyDonationButton.backgroundColor = UIColor.backgroundColor
            buyGoldButton.isEnabled = false
            buyGoldButton.alpha = 0.4
            buyGoldButton.backgroundColor = UIColor.backgroundColor
        }
        else {
            buyLabel.isHidden = false
            levelRequiredLabel.textColor = UIColor.textColor
            buyDonationButton.isEnabled = donationBalls >= item.buyCostDonation
            buyDonationButton.alpha = donationBalls >= item.buyCostDonation ? 1.0 : 0.4
            buyDonationButton.backgroundColor = donationBalls >= item.buyCostDonation ? UIColor.white : UIColor.backgroundColor
            buyGoldButton.isEnabled = gold >= item.buyCostGold
            buyGoldButton.alpha = gold >= item.buyCostGold ? 1.0 : 0.4
            buyGoldButton.backgroundColor = gold >= item.buyCostGold ? UIColor.white : UIColor.backgroundColor
        }
        if item.buyCostDonation == 0 {
            buyDonationWidthConstraint.constant = 0
            buyDonationButton.isHidden = true
            buyGoldWidthConstraint.constant = width
            buyGoldButton.layoutIfNeeded()
        }
        else {
            buyDonationWidthConstraint.constant = width / 2
            buyDonationButton.isHidden = false
            buyGoldWidthConstraint.constant = width / 2
        }
    }
}
