//
//  SegmentedView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 22.08.2021.
//

import UIKit

class SegmentedView: UIView {
    
    var numberOfSegments: Int = 2
    
    let stackView = UIStackView()
    let leftSeparator = UIView()
    let rightSeparator = UIView()
    
    let firstButton = SegmentButton()
    let secondButton = SegmentButton()
    let thirdButton = SegmentButton()

    convenience init(numberOfSegments: Int) {
        self.init()
        self.numberOfSegments = numberOfSegments
        initialSetup()
    }
    
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
        stackView.alignment = .center
        stackView.spacing = 0
        leftSeparator.setDimensions(width: 1, height: 26)
        leftSeparator.backgroundColor = UIColor.AppColors.darkGreen.withAlphaComponent(0.2)
        rightSeparator.backgroundColor = UIColor.AppColors.darkGreen.withAlphaComponent(0.2)
        rightSeparator.setDimensions(width: 1, height: 26)
        firstButton.setDimensions(height: 44)
        secondButton.setDimensions(height: 44)
        thirdButton.setDimensions(height: 44)
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(leftSeparator)
        stackView.addArrangedSubview(secondButton)
        if numberOfSegments == 3 {
            stackView.addArrangedSubview(rightSeparator)
            stackView.addArrangedSubview(thirdButton)
        }
    }
}
