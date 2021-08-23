//
//  ButtonWithCount.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 22.08.2021.
//

import UIKit

class ButtonWithCount: ButtonWithShadow {
    
    var axis: NSLayoutConstraint.Axis = .horizontal {
        didSet {
            stackView.axis = axis
        }
    }
    
    var image: UIImage? {
        didSet {
            imageWithCount.image = image
        }
    }
    
    var count: Int = 0 {
        didSet {
            imageWithCount.count = count
        }
    }
    
    var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    let stackView = UIStackView()
    let imageWithCount = CountedImageView()
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        stackView.center(in: self)
        stackView.axis = axis
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.addArrangedSubview(imageWithCount)
        stackView.addArrangedSubview(label)
        imageWithCount.setDimensions(width: 50, height: 50)
        label.textColor = UIColor.textColor
        label.font = UIFont.normalTextFont
    }
}
