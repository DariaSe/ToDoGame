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
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let pickFruitsButton = UIButton()
    let pickFruitsView = CountedImageView()
    
    let lowerContainerView = UIView()
    let waterButton = ButtonWithCount()
    let fertilizeButton = ButtonWithCount()
    
    let shadowView = ShadowView()
    
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
        contentView.pinToEdges(subview: shadowView, leading: 5, trailing: 5, top: 5, bottom: 5)
        contentView.pinToEdges(subview: lowerContainerView, leading: 5, trailing: 5, top: 5, bottom: 5)
        lowerContainerView.backgroundColor = UIColor(netHex: 0xE0DFDC)
        lowerContainerView.layer.cornerRadius = 20
        lowerContainerView.pinToEdges(subview: waterButton, leading: nil, trailing: 0, top: 0, bottom: nil)
        waterButton.setDimensions(width: 80, height: 119)
        waterButton.image = UIImage(named: "Water")
        waterButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        lowerContainerView.pinToEdges(subview: fertilizeButton, leading: nil, trailing: 0, top: nil, bottom: 0)
        fertilizeButton.setDimensions(width: 80, height: 119)
        fertilizeButton.image = UIImage(named: "Fertilizer")
        
        contentView.pinToEdges(subview: upperContainerView, leading: 5, trailing: 5, top: 5, bottom: 5)
        upperContainerView.backgroundColor = UIColor.backgroundColor
        upperContainerView.layer.cornerRadius = 20
        upperContainerView.pinToEdges(subview: imageView, leading: nil, trailing: nil, top: 21, bottom: nil)
        imageView.centerXAnchor.constraint(equalTo: upperContainerView.centerXAnchor).isActive = true
        imageView.setDimensions(width: 140, height: 140)
        imageView.image = UIImage(named: "Seed placeholder")
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        upperContainerView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: upperContainerView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 11).isActive = true
        titleLabel.textColor = UIColor.AppColors.darkGreen
        titleLabel.font = UIFont(name: nunitoBold, size: 18)!
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        upperContainerView.addSubview(descriptionLabel)
        descriptionLabel.centerXAnchor.constraint(equalTo: upperContainerView.centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3).isActive = true
        descriptionLabel.textColor = UIColor.AppColors.darkGreen
        descriptionLabel.font = UIFont.normalTextFont
        
        upperContainerView.pinToLayoutMargins(subview: pickFruitsButton, leading: nil, trailing: 2, top: 2, bottom: nil)
        pickFruitsButton.setDimensions(width: 70, height: 70)
        pickFruitsButton.pinToEdges(subview: pickFruitsView)
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
                    self.upperContainerView.frame = CGRect(x: -self.buttonWidth + 5, y: 5, width: self.upperContainerView.frame.width, height: self.upperContainerView.frame.height)
                }, completion: nil)
            }
            else {
                restoreFrame()
            }
        }
    }
    
    func restoreFrame() {
        UIView.animate(withDuration: 0.3, delay: 0.1, options: [.curveEaseOut], animations: {
            self.upperContainerView.frame = CGRect(x: 5, y: 5, width: self.upperContainerView.frame.width, height: self.upperContainerView.frame.height)
        }, completion: nil)
        pickFruitsButton.isEnabled = true
        isEditMode = false
    }
    
    func update(with plant: Plant) {
        titleLabel.text = plant.species.title + " (" + NSLocalizedString(plant.state.rawValue, comment: "") + ")"
        descriptionLabel.text = plant.stateDescription
        waterButton.count = plant.species.waterConsumption
        fertilizeButton.count = plant.species.fertilizerConsumption
        pickFruitsButton.isHidden = plant.state != .fruiting || plant.harvestDates.contains(Date().dayStart)
        pickFruitsView.image = UIImage(named: "Seed placeholder")
        pickFruitsView.count = plant.species.nominalYield
    }
}

extension GardenCollectionViewCell: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
