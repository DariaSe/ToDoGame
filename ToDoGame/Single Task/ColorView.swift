//
//  ColorView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 18.06.2021.
//

import UIKit

class ColorView: CheckboxView {
    
    var isColorSet: Bool = false {
        didSet {
            isCheckboxOn = isColorSet
            UIView.animate(withDuration: 0.1) {
                self.colorButton.alpha = self.isColorSet ? 1.0 : 0.0
            }
        }
    }
    
    var color: Int = 0 {
        didSet {
            colorButton.backgroundColor = UIColor.tagColor(index: color)
        }
    }
    
    let colorButton = UIButton()
    
    lazy var colorCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: colorCollectionViewLayout)
    let colorCollectionViewLayout = UICollectionViewFlowLayout()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initialSetup() {
        super.initialSetup()
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(colorButton)
        colorButton.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 20).isActive = true
        colorButton.centerYAnchor.constraint(equalTo: checkboxButton.centerYAnchor).isActive = true
        colorButton.setDimensions(width: 40, height: 40)
        label.text = Strings.color
        colorButton.layer.cornerRadius = 10
        colorButton.backgroundColor = UIColor.tagColor(index: color)
        colorButton.alpha = 0.0
        checkboxToggled = {
            self.isColorSet = !self.isColorSet
        }
    }
}
