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
        self.pinToEdges(subview: stackView)
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(plantsButton)
        stackView.addArrangedSubview(leftSeparator)
        stackView.addArrangedSubview(itemsButton)
        stackView.addArrangedSubview(rightSeparator)
        stackView.addArrangedSubview(recipesButton)
        leftSeparator.setDimensions(width: 1)
        leftSeparator.backgroundColor = UIColor.AppColors.darkGreen.withAlphaComponent(0.2)
        rightSeparator.setDimensions(width: 1)
        rightSeparator.backgroundColor = UIColor.AppColors.darkGreen.withAlphaComponent(0.2)
        plantsButton.setDimensions(height: 44)
        plantsButton.text = Strings.plants
        plantsButton.tag = 0
        plantsButton.isActive = true
        plantsButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        itemsButton.setDimensions(height: 44)
        itemsButton.text = Strings.items
        itemsButton.tag = 1
        itemsButton.isActive = false
        itemsButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        recipesButton.setDimensions(height: 44)
        recipesButton.text = Strings.recipes
        recipesButton.tag = 2
        recipesButton.isActive = false
        recipesButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
    }
    
    @objc func buttonPressed(sender: SegmentButton) {
        didSelectSegment?(sender.tag)
        for button in buttons {
            button.isActive = button == sender
        }
    }
}
