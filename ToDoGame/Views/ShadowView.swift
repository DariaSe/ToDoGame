//
//  ShadowView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 22.08.2021.
//

import UIKit

class ShadowView: UIView {
    
    var cornerRadius: CGFloat = 12
    var color: UIColor = UIColor.black
    var opacity: Float = 0.2
    var height: CGFloat = 3
    var shadowRadius: CGFloat = 6

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        
    }
    
    func setupShadow() {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 0, height: height)
        layer.shadowRadius = shadowRadius
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
    }
}
