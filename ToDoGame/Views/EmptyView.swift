//
//  EmptyView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 24.08.2021.
//

import UIKit

class EmptyView: UIView {
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    let imageView = UIImageView()
    let label = UILabel()
    let reloadButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -60).isActive = true
        imageView.setDimensions(width: 160, height: 160)
    }
}
