//
//  TextViewContainer.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 28.05.2021.
//

import UIKit

class TextViewContainer: UIView {
    
    var textView = UITextView()
    // to assign
    var text: String? {
        didSet {
            textView.text = self.text
            configureTextAppearance()
        }
    }
    
    var textViewBackgroundColor: UIColor = UIColor.textControlsBGColor
    var textColor: UIColor = UIColor.textColor
    
    var placeholder: String = "" {
        didSet {
            configureTextAppearance()
        }
    }
    var placeholderTextColor: UIColor = UIColor.lightGray
    
    var textChanged: ((String) -> Void)?
    
    var isValid: Bool {
        return textView.isValid(placeholder: placeholder)
    }
    
    func configureTextAppearance() {
        if textView.text == "" {
            textView.text = placeholder
        }
        textView.textColor = textView.text == placeholder ?
            placeholderTextColor : textColor
    }
    
    func configureLayerAppearance() {
        backgroundColor = .clear
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 12
        textView.backgroundColor = textViewBackgroundColor
        textView.isEditable = true
    }
    
    func initialSetup() {
        textView.pinToEdges(to: self)
        textView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        textView.delegate = self
        textView.isScrollEnabled = false
        textView.font = UIFont.normalTextFont
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        configureLayerAppearance()
        configureTextAppearance()
//        NotificationCenter.default.addObserver(self, selector: #selector(showInvalidTextView), name: Notification.Name(doneButtonNKey), object: nil)
    }
    
    @objc func showInvalidTextView() {
        if !isValid {
            textView.layer.borderColor = UIColor.TagColors.red.cgColor
            textView.layer.borderWidth = 2
            textView.shake()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }
}

extension TextViewContainer: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= 400
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
        if textView.text.last == "\n" {
            textView.text.removeLast()
            self.endEditing(true)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.clear(placeholder: placeholder)
        textView.textColor = textColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.show(placeholder: placeholder, placeholderColor: placeholderTextColor)
    }
}
