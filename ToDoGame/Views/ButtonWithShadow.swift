//
//  ButtonWithShadow.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 22.08.2021.
//

import UIKit

class ButtonWithShadow: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        common()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        common()
    }
    
    private func common() {
        // UIButton is tricky: you MUST set the clear bg in bringup;  NOT in layout
        backgroundColor = .clear
        clipsToBounds = false
        self.layer.insertSublayer(colorAndShadow, below: layer)
    }
    
    lazy var colorAndShadow: CAShapeLayer = {
        let s = CAShapeLayer()
        // set your button color HERE (NOT on storyboard)
        s.fillColor = UIColor.backgroundColor.cgColor
        // now set your shadow color/values
        s.shadowColor = UIColor.black.cgColor
        s.shadowOffset = CGSize(width: 0, height: 3)
        s.shadowOpacity = 0.2
        s.shadowRadius = 6
        // now add the shadow
        layer.insertSublayer(s, at: 0)
        return s
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // you MUST layout these two EVERY layout cycle:
        colorAndShadow.frame = bounds
        colorAndShadow.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
    }
}

