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
        layer.cornerRadius = SizeConstants.textFieldCornerRadius
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.borderColor.cgColor
        font = UIFont.normalTextFont
        textColor = UIColor.textColor
        textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        isScrollEnabled = false
    }
}
