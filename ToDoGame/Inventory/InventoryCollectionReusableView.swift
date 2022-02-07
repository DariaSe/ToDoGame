//
//  InventoryCollectionReusableView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 23.08.2021.
//

import UIKit

class InventoryCollectionReusableView: UICollectionReusableView {
    
    static let reuseIdentifier = "InventoryHeaderView"
    
    var title: String = "" {
        didSet {
            label.text = title.uppercased()
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
        label.center(in: self)
        label.font = UIFont(name: nunitoExtraBold, size: 14)!
        label.textColor = UIColor.textColor
    }
}
