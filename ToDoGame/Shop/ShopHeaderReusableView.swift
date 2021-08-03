//
//  ShopHeaderReusableView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 03.08.2021.
//

import UIKit

class ShopHeaderReusableView: UICollectionReusableView {
    
    static let reuseIdentifier = "ShopHeaderView"
    
    var title: String = "" {
        didSet {
            label.text = title
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
        self.pinToLayoutMargins(subview: label, leading: 10)
        label.font = UIFont.buttonFont
        label.textColor = UIColor.textColor
    }
        
}
