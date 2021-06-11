//
//  AppTextView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 19.05.2021.
//

import UIKit

class AppTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        backgroundColor = UIColor.textControlsBGColor
        layer.cornerRadius = SizeConstants.textFieldCornerRadius
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.borderColor.cgColor
    }
}
