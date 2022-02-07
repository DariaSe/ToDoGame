//
//  GardenButton.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 06.09.2021.
//

import UIKit

class GardenButton: UIButton {
    
    var isActive: Bool = true {
        didSet {
            isEnabled = isActive
            backgroundColor = isActive ? UIColor.backgroundColor.withAlphaComponent(0.5) : UIColor.clear
            alpha = isActive ? 1.0 : 0.7
        }
    }
    
    var image: UIImage? {
        didSet {
            setImage(image, for: .normal)
        }
    }
    
    var text: String = "" {
        didSet {
            label.text = text.uppercased()
        }
    }
    
    var count: Int = 0 {
        didSet {
            
        }
    }
    
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToEdges(subview: label, leading: 0, trailing: 0, top: nil, bottom: 20)
        label.font = UIFont(name: nunitoSemiBold, size: 10)!
        label.textColor = UIColor.darkGray.withAlphaComponent(0.8)
        label.textAlignment = .center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
}
