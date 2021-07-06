//
//  ColorComposedView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 20.06.2021.
//

import UIKit

class ColorComposedView: UIView {
    
    var isColorSet: Bool = false {
        didSet {
            checkboxView.isColorSet = isColorSet
        }
    }
    
    var color: Int = UserDefaultsService.lastColor {
        didSet {
            checkboxView.color = color
        }
    }
    
    var isColorPickerShown: Bool = false {
        didSet {
            UIView.transition(with: colorCollectionView, duration: 0.2, options: [.transitionCrossDissolve]) {
                self.colorCollectionView.isHidden = self.isColorPickerShown ? false : true
                self.colorCollectionViewHeightConstraint.constant = self.isColorPickerShown ? 110 : 0
            }
        }
    }
    
    let checkboxView = ColorCheckboxView()
    let colorCollectionView = ColorCollectionView()
    
    var colorCollectionViewHeightConstraint = NSLayoutConstraint()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToEdges(subview: checkboxView, bottom: nil)
        self.pinToEdges(subview: colorCollectionView, top: nil)
        checkboxView.bottomAnchor.constraint(equalTo: colorCollectionView.topAnchor).isActive = true
        colorCollectionViewHeightConstraint = colorCollectionView.heightAnchor.constraint(equalToConstant: 0)
        colorCollectionViewHeightConstraint.isActive = true
        colorCollectionView.isHidden = true
        checkboxView.checkboxToggled = { [unowned self] in
            isColorSet = !isColorSet
            if isColorPickerShown {
                isColorPickerShown = false
            }
        }
        checkboxView.colorButton.addTarget(self, action: #selector(colorButtonPressed), for: .touchUpInside)
        colorCollectionView.didSelectColor = { [unowned self] colorIndex in
            color = colorIndex
            isColorPickerShown = false
        }
    }
    
    @objc func colorButtonPressed() {
        checkboxView.colorButton.animateScale(duration: 0.1, scale: 1.1)
        isColorPickerShown = !isColorPickerShown
    }
}
