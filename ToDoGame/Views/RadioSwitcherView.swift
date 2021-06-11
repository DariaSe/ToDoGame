//
//  RadioSwitcherView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 11.06.2021.
//

import UIKit

class RadioSwitcherView: UIView {
    
    var axis: NSLayoutConstraint.Axis = .horizontal {
        didSet {
            stackView.axis = self.axis
            layoutIfNeeded()
        }
    }
    
    var alignment: UIStackView.Alignment = .center {
        didSet {
            stackView.alignment = self.alignment
            layoutIfNeeded()
        }
    }
    
    var spacing: CGFloat = 20 {
        didSet {
            stackView.spacing = self.spacing
        }
    }
    
    var options: [UIView] = [] {
        didSet {
            for option in options {
                let optionStackView = UIStackView()
                optionStackView.axis = .horizontal
                optionStackView.alignment = .top
            }
            layoutIfNeeded()
        }
    }
    
    private var buttons: [UIButton] = []
    
    
    let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        pinToEdges(subview: stackView)
        stackView.axis = self.axis
        stackView.alignment = self.alignment
        stackView.spacing = self.spacing
    }
}
