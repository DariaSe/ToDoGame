//
//  AppTextField.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 16.06.2021.
//

import UIKit

class AppTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        layer.cornerRadius = SizeConstants.textFieldCornerRadius
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.borderColor.cgColor
        font = UIFont.normalTextFont
        textColor = UIColor.textColor
    }
}
