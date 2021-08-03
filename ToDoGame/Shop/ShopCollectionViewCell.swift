//
//  ShopCollectionViewCell.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 02.08.2021.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ShopCell"
    
    let containerView = UIView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let goldImageView = UIImageView()
    let goldLabel = UILabel()
    let donationImageView = UIImageView()
    let donationLabel = UILabel()
    let lockImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        contentView.backgroundColor = .clear
        contentView.pinToEdges(subview: containerView, leading: 4, trailing: 4, top: 4, bottom: 4)
        containerView.layer.cornerRadius = 18
        containerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowColor = UIColor.blue.cgColor
        containerView.layer.shadowOpacity = 0.16
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor(netHex: 0xf5f5f5).cgColor
        containerView.backgroundColor = .white
        imageView.center(in: containerView)
        imageView.setDimensions(width: 50, height: 50)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.shopFont
        titleLabel.textColor = UIColor.textColor
        containerView.pinToLayoutMargins(subview: donationImageView, trailing: nil, bottom: nil)
        donationImageView.setDimensions(width: 16, height: 16)
        donationImageView.image = UIImage(named: "Crystal ball")
        donationLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(donationLabel)
        donationLabel.leadingAnchor.constraint(equalTo: donationImageView.trailingAnchor, constant: 5).isActive = true
        donationLabel.centerYAnchor.constraint(equalTo: donationImageView.centerYAnchor).isActive = true
        donationLabel.font = UIFont.shopFont
        donationLabel.textColor = UIColor.textColor
        donationLabel.textAlignment = .left
        containerView.pinToLayoutMargins(subview: goldLabel, leading: nil, top: nil, bottom: nil)
        goldLabel.centerYAnchor.constraint(equalTo: donationImageView.centerYAnchor).isActive = true
        goldLabel.font = UIFont.shopFont
        goldLabel.textColor = UIColor.textColor
        goldLabel.textAlignment = .right
        goldImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(goldImageView)
        goldImageView.centerYAnchor.constraint(equalTo: goldLabel.centerYAnchor).isActive = true
        goldImageView.trailingAnchor.constraint(equalTo: goldLabel.leadingAnchor, constant: -5).isActive = true
        goldImageView.setDimensions(width: 16, height: 16)
        goldImageView.image = UIImage(named: "Coin")
        contentView.addSubview(lockImageView)
        lockImageView.center(in: contentView)
        lockImageView.setDimensions(width: 90, height: 90)
        lockImageView.image = UIImage(named: "Lock")
        lockImageView.alpha = 0.4
    }
    
    func update(with item: ShopItem) {
        titleLabel.text = item.title
        goldLabel.text = item.buyCostGold.string
        donationLabel.text = item.buyCostDonation == 0 ? "" : item.buyCostDonation.string
        donationImageView.isHidden = item.buyCostDonation == 0
        imageView.image = UIImage(named: "Seed placeholder")
        let level = LevelManager.currentLevel
        lockImageView.isHidden = level >= item.levelRequired
        containerView.alpha = (level >= item.levelRequired) ? 1.0 : 0.25
    }
}
