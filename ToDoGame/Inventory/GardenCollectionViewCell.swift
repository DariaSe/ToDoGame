//
//  GardenCollectionViewCell.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 02.08.2021.
//

import UIKit

class GardenCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "GardenCell"
    
    var isEditMode: Bool = false
    
    let upperContainerView = UIView()
    let backgroundColorView = UIView()
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let stateLabel = UILabel()
    let descriptionLabel = UILabel()
    let pickFruitsButton = UIButton()
    let pickFruitsView = CountedImageView()
    
    let lowerContainerView = UIView()
    let waterButton = GardenButton()
    let fertilizeButton = GardenButton()
    
    let panGestureRecognizer = UIPanGestureRecognizer()
    
    let buttonWidth: CGFloat = 85
    var distance: CGFloat = 0
    var showFullWidth: Bool = false
    
    var waterPressed: (() -> ())?
    var fertilizePressed: (() -> ())?
    var pickFruitsPressed: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        contentView.pinToEdges(subview: lowerContainerView, leading: 3, trailing: 3, top: 3, bottom: 3)
        lowerContainerView.backgroundColor = UIColor(netHex: 0xEBEBEB)
        lowerContainerView.layer.cornerRadius = 20
        lowerContainerView.pinToEdges(subview: waterButton, leading: nil, trailing: 0, top: 0, bottom: nil)
        waterButton.setDimensions(width: 80, height: 125)
        waterButton.image = UIImage(named: "Watering_vertical")
        waterButton.text = Strings.waterVerb
        waterButton.layer.cornerRadius = 20
        waterButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        lowerContainerView.pinToEdges(subview: fertilizeButton, leading: nil, trailing: 0, top: nil, bottom: 0)
        fertilizeButton.setDimensions(width: 80, height: 125)
        fertilizeButton.image = UIImage(named: "Fertilizer_vertical")
        fertilizeButton.text = Strings.fertilize
        fertilizeButton.layer.cornerRadius = 20
        fertilizeButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        
        contentView.pinToEdges(subview: upperContainerView, leading: 3, trailing: 3, top: 3, bottom: 3)
        upperContainerView.layer.shadowRadius = 5
        upperContainerView.layer.shadowOpacity = 0.2
        upperContainerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        upperContainerView.layer.shadowColor = UIColor.black.cgColor
        
        upperContainerView.pinToEdges(subview: backgroundColorView)
        backgroundColorView.backgroundColor = UIColor.backgroundColor
        backgroundColorView.layer.cornerRadius = 20
        
        upperContainerView.pinToEdges(subview: imageView, leading: nil, trailing: nil, top: 20, bottom: nil)
        imageView.centerXAnchor.constraint(equalTo: upperContainerView.centerXAnchor).isActive = true
        imageView.setDimensions(width: 140, height: 140)
        imageView.image = UIImage(named: "Seed placeholder")
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        upperContainerView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: upperContainerView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 11).isActive = true
        titleLabel.textColor = UIColor.textColor
        titleLabel.font = UIFont(name: nunitoBold, size: 18)!
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        upperContainerView.addSubview(stateLabel)
        stateLabel.centerXAnchor.constraint(equalTo: upperContainerView.centerXAnchor).isActive = true
        stateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3).isActive = true
        stateLabel.textColor = UIColor.textColor
        stateLabel.font = UIFont(name: nunitoRegular, size: 14)!
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        upperContainerView.addSubview(descriptionLabel)
        descriptionLabel.centerXAnchor.constraint(equalTo: upperContainerView.centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 1).isActive = true
        descriptionLabel.textColor = UIColor.textColor
        descriptionLabel.font = UIFont(name: nunitoRegular, size: 12)!
        
        upperContainerView.pinToLayoutMargins(subview: pickFruitsButton, leading: nil, trailing: 2, top: 2, bottom: nil)
        pickFruitsButton.setDimensions(width: 70, height: 70)
        pickFruitsButton.backgroundColor = UIColor.white
        pickFruitsButton.layer.cornerRadius = 12
        pickFruitsButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        pickFruitsButton.pinToEdges(subview: pickFruitsView, leading: 3, trailing: 3, top: 3, bottom: 3)
        pickFruitsView.isUserInteractionEnabled = false
        
        upperContainerView.addGestureRecognizer(panGestureRecognizer)
        panGestureRecognizer.delegate = self
        panGestureRecognizer.addTarget(self, action: #selector(dragged(sender:)))
    }
    
    
    @objc func buttonPressed(sender: UIButton) {
        sender.animateScale(duration: 0.1, scale: 1.1)
        switch sender {
        case waterButton: waterPressed?()
        case fertilizeButton: fertilizePressed?()
        case pickFruitsButton: pickFruitsPressed?()
        default: break
        }
    }
    
    @objc func dragged(sender: UIPanGestureRecognizer) {
        if sender.state == .changed {
            let translation = sender.translation(in: self.contentView)
            guard abs(translation.x) > abs(translation.y) else { return }
            if upperContainerView.center.x + translation.x < contentView.center.x && distance <= buttonWidth {
                upperContainerView.center = CGPoint(x: upperContainerView.center.x + translation.x, y: upperContainerView.center.y)
                pickFruitsButton.isEnabled = false
                isEditMode = true
            }
            let positionAdjustment = abs(self.contentView.center.x - upperContainerView.center.x)
            distance = positionAdjustment
            sender.setTranslation(CGPoint.zero, in: self.contentView)
            showFullWidth = positionAdjustment > (buttonWidth / 2)
        }
        if sender.state == .ended {
            if showFullWidth {
                UIView.animate(withDuration: 0.2, delay: 0.1, options: [.curveEaseOut], animations: {
                    self.upperContainerView.frame = CGRect(x: -self.buttonWidth + 3, y: 3, width: self.upperContainerView.frame.width, height: self.upperContainerView.frame.height)
                }, completion: nil)
            }
            else {
                restoreFrame()
            }
        }
    }
    
    func restoreFrame() {
        UIView.animate(withDuration: 0.3, delay: 0.1, options: [.curveEaseOut], animations: {
            self.upperContainerView.frame = CGRect(x: 3, y: 3, width: self.upperContainerView.frame.width, height: self.upperContainerView.frame.height)
        }, completion: nil)
        pickFruitsButton.isEnabled = true
        isEditMode = false
    }
    
    func update(with plant: Plant) {
        titleLabel.text = plant.species.title
        stateLabel.text = NSLocalizedString(plant.state.rawValue, tableName: "Game", comment: "").capitalized
        descriptionLabel.text = plant.stateDescription
        waterButton.count = plant.species.waterConsumption
        fertilizeButton.count = plant.species.fertilizerConsumption
        pickFruitsButton.isHidden = plant.state != .fruiting || plant.harvestDates.contains(Date().dayStart)
        pickFruitsView.image = UIImage(named: "tomato_fruit")
        pickFruitsView.count = plant.species.nominalYield
        let user = UserService.shared.user
        let wasWateredToday = plant.wateringDates.contains(Date().dayStart)
        let isEnoughWater = user.water >= plant.species.waterConsumption
        waterButton.isActive = !wasWateredToday && isEnoughWater
        let wasFertilizedToday = plant.fertilizerDates.contains(Date().dayStart)
        let isEnoughFertilizer = user.fertilizer >= plant.species.fertilizerConsumption
        fertilizeButton.isActive = !wasFertilizedToday && wasWateredToday && isEnoughFertilizer
    }
}

extension GardenCollectionViewCell: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
