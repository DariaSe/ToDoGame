//
//  CountedImageView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 22.08.2021.
//

import UIKit

class CountedImageView: UIView {
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var count: Int = 0 {
        didSet {
            numberLabel.text = count.string
        }
    }
    
    let imageView = UIImageView()
    let circleView = UIView()
    let s = CAShapeLayer()

    let numberLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToEdges(subview: imageView)
        self.pinToEdges(subview: circleView, leading: nil, trailing: 2, top: 2, bottom: nil)
        circleView.setDimensions(width: 20, height: 20)
        circleView.layer.cornerRadius = 10
        circleView.backgroundColor = UIColor.backgroundColor
        s.fillColor = UIColor.backgroundColor.cgColor
        s.shadowColor = UIColor.black.cgColor
        s.shadowOffset = CGSize(width: 0, height: 0)
        s.shadowOpacity = 0.2
        s.shadowRadius = 6
        circleView.layer.insertSublayer(s, at: 0)
        numberLabel.center(in: circleView)
        numberLabel.font = UIFont(name: nunitoRegular, size: 12)
        numberLabel.textColor = UIColor.textColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        s.frame = bounds
        s.path = UIBezierPath(roundedRect: circleView.bounds, cornerRadius: 10).cgPath
    }
}
