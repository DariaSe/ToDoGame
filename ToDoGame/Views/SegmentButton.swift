//
//  SegmentButton.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 22.08.2021.
//

import UIKit

class SegmentButton: UIButton {
    
    var isActive: Bool = false {
        didSet {
            label.font = isActive ? UIFont(name: nunitoBold, size: 16)! : UIFont.normalTextFont
            label.alpha = isActive ? 1.0 : 0.8
            stripeView.alpha = isActive ? 1.0 : 0.2
        }
    }
    
    var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    let label = UILabel()
    let stripeView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        label.center(in: self)
        label.textColor = UIColor.textColor
        label.isUserInteractionEnabled = false
        
        self.pinToEdges(subview: stripeView, leading: 24, trailing: 24, top: nil, bottom: 0)
        stripeView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        stripeView.layer.cornerRadius = 2
        stripeView.backgroundColor = UIColor.AppColors.darkGreen.withAlphaComponent(0.8)
        stripeView.isUserInteractionEnabled = false
    }
}
