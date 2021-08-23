//
//  InventorySegmentView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 22.08.2021.
//

import UIKit

class InventorySegmentView: UIView {
    
    let stackView = UIStackView()
    
    let plantsButton = SegmentButton()
    let itemsButton = SegmentButton()
    let recipesButton = SegmentButton()
    
    lazy var buttons = [plantsButton, itemsButton, recipesButton]
    
    let leftSeparator = UIView()
    let rightSeparator = UIView()
    
    var didSelectSegment: ((Int) -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.addArrangedSubview(plantsButton)
        stackView.addArrangedSubview(leftSeparator)
        stackView.addArrangedSubview(itemsButton)
        stackView.addArrangedSubview(rightSeparator)
        stackView.addArrangedSubview(recipesButton)
        leftSeparator.setDimensions(width: 1, height: 26)
        leftSeparator.backgroundColor = UIColor.AppColors.darkGreen.withAlphaComponent(0.2)
        rightSeparator.setDimensions(width: 1, height: 26)
        rightSeparator.backgroundColor = UIColor.AppColors.darkGreen.withAlphaComponent(0.2)
        let buttonWidth = (UIScreen.main.bounds.width - 22) / 3 - 1
        plantsButton.setDimensions(width: buttonWidth, height: 44)
        plantsButton.text = Strings.plants
        plantsButton.tag = 0
        plantsButton.isActive = true
        itemsButton.setDimensions(width: buttonWidth, height: 44)
        itemsButton.text = Strings.items
        itemsButton.tag = 1
        itemsButton.isActive = false
        recipesButton.setDimensions(width: buttonWidth, height: 44)
        recipesButton.text = Strings.recipes
        recipesButton.tag = 2
        recipesButton.isActive = false
    }
    
    @objc func buttonPressed(sender: SegmentButton) {
        sender.animateScale(duration: 0.1, scale: 1.1)
        didSelectSegment?(sender.tag)
        for button in buttons {
            button.isActive = button == sender
        }
    }
}
