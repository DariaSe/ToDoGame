//
//  ButtonWithCount.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 22.08.2021.
//

import UIKit

class ButtonWithCount: UIButton {
    
    var isActive: Bool = true {
        didSet {
            isUserInteractionEnabled = isActive
            upperView.isHidden = !isActive
            label.alpha = isActive ? 1.0 : 0.5
        }
    }
    
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
    let upperView = UIView()
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
        backgroundColor = UIColor(netHex: 0xDBDAD7)
        layer.cornerRadius = 20
        clipsToBounds = true
        self.pinToEdges(subview: upperView, leading: 1, trailing: 2, bottom: 4)
        upperView.layer.cornerRadius = 20
        upperView.isUserInteractionEnabled = false
        upperView.backgroundColor = .white
        stackView.center(in: self)
        stackView.axis = axis
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.addArrangedSubview(imageWithCount)
        stackView.addArrangedSubview(label)
        imageWithCount.setDimensions(width: 50, height: 50)
        label.textColor = UIColor.textColor
        label.font = UIFont.normalTextFont
        stackView.isUserInteractionEnabled = false
    }
}
