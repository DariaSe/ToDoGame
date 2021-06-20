//
//  RepeatWithIntervalView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 16.06.2021.
//

import UIKit

class RepeatWithIntervalView: UIView {
    
    var recurrenceFrequency: RecurrenceFrequency = .daily {
        didSet {
            updateDropdownButtonText(interval: interval)
        }
    }
    
    var interval: Int = 0 {
        didSet {
            textField.text = String(interval)
        }
    }
    
    var textDidChange: (() -> ())?
    
    let label = UILabel()
    let textField = AppTextField()
    let dropdownButton = DropdownButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToEdges(subview: label, trailing: nil, top: nil, bottom: nil)
        self.pinToEdges(subview: textField, leading: nil, trailing: nil)
        self.pinToEdges(subview: dropdownButton, leading: nil, trailing: nil)
        label.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -20).isActive = true
        label.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: dropdownButton.leadingAnchor, constant: -20).isActive = true
        dropdownButton.heightAnchor.constraint(equalToConstant: SizeConstants.buttonHeight).isActive = true
        
        label.text = Strings.every
        label.font = UIFont.normalTextFont
        label.textColor = UIColor.textColor
        textField.setDimensions(width: 60)
        textField.keyboardType = .decimalPad
        textField.setLeftPaddingPoints(16)
        textField.setRightPaddingPoints(16)
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        dropdownButton.text = Strings.daysCount.localizedForCount(5)
    }
    
    func updateDropdownButtonText(interval: Int) {
        switch recurrenceFrequency {
        case .daily: dropdownButton.text = Strings.daysCount.localizedForCount(interval)
        case .weekly: dropdownButton.text = Strings.weeksCount.localizedForCount(interval)
        case .monthly: dropdownButton.text = Strings.monthsCount.localizedForCount(interval)
        case .yearly: dropdownButton.text = Strings.yearsCount.localizedForCount(interval)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let count = Int(textField.text ?? "") {
            updateDropdownButtonText(interval: count)
        }
    }
}

extension RepeatWithIntervalView: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textDidChange?()
        if let text = textField.text, let count = Int(text) {
            interval = count
        }
    }
}
