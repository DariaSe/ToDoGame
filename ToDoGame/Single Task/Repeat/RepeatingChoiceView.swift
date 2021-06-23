//
//  RepeatingChoiceView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 20.06.2021.
//

import UIKit

class RepeatingChoiceView: UIView {
    
    var delegate: DropdownDelegate?
    
    var selectedOption: Int = 0 {
        didSet {
            for (index, button) in buttons.enumerated() {
                button.isSelected = (index == selectedOption)
            }
        }
    }
    
    var didSelectOption: ((Int) -> ())?
    
    var buttons: [UIButton] { [firstRadioButton, secondRadioButton, thirdRadioButton] }
    
    let firstOptionContainer = UIView()
    let secondOptionContainer = UIView()
    let thirdOptionContainer = UIView()
    
    let firstRadioButton = RadioButton()
    let secondRadioButton = RadioButton()
    let thirdRadioButton = RadioButton()
    
    let noIntervalDropdownButton = DropdownButton()
    let repeatWithIntervalOption = RepeatWithIntervalView()
    let weekdaysOptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToEdges(subview: firstOptionContainer, bottom: nil)
        self.pinToEdges(subview: secondOptionContainer, top: nil, bottom: nil)
        self.pinToEdges(subview: thirdOptionContainer, top: nil)
        
        firstOptionContainer.bottomAnchor.constraint(equalTo: secondOptionContainer.topAnchor).isActive = true
        secondOptionContainer.bottomAnchor.constraint(equalTo: thirdOptionContainer.topAnchor).isActive = true

        firstOptionContainer.pinToLayoutMargins(subview: firstRadioButton, trailing: nil, bottom: nil)
        secondOptionContainer.pinToLayoutMargins(subview: secondRadioButton, trailing: nil, bottom: nil)
        thirdOptionContainer.pinToLayoutMargins(subview: thirdRadioButton, trailing: nil, bottom: nil)
        
        firstRadioButton.setDimensions(width: 40, height: 40)
        firstRadioButton.addTarget(self, action: #selector(radioButtonPressed(sender:)), for: .touchUpInside)
        firstRadioButton.isSelected = true
        firstRadioButton.tag = 0
        secondRadioButton.setDimensions(width: 40, height: 40)
        secondRadioButton.addTarget(self, action: #selector(radioButtonPressed(sender:)), for: .touchUpInside)
        secondRadioButton.tag = 1
        thirdRadioButton.setDimensions(width: 40, height: 40)
        thirdRadioButton.addTarget(self, action: #selector(radioButtonPressed(sender:)), for: .touchUpInside)
        thirdRadioButton.tag = 2
        
        let container = UIView()
        container.pinToEdges(subview: noIntervalDropdownButton, trailing: nil)
        firstOptionContainer.pinToLayoutMargins(subview: container, leading: 60)
        noIntervalDropdownButton.heightAnchor.constraint(equalToConstant: SizeConstants.buttonHeight).isActive = true
        noIntervalDropdownButton.text = Strings.daily
        noIntervalDropdownButton.addTarget(self, action: #selector(noIntervalDropdownPressed), for: .touchUpInside)
        
        secondOptionContainer.pinToLayoutMargins(subview: repeatWithIntervalOption, leading: 60)
        repeatWithIntervalOption.dropdownButton.addTarget(self, action: #selector(intervalOptionDropdownPressed), for: .touchUpInside)
        repeatWithIntervalOption.textDidChange = { [unowned self] in
            didSelectOption?(1)
        }
        
        let weekdaysOptionView = UIView()
        weekdaysOptionView.pinToLayoutMargins(subview: weekdaysOptionLabel, leading: -10, bottom: nil)
        thirdOptionContainer.pinToLayoutMargins(subview: weekdaysOptionView, leading: 60)
        weekdaysOptionLabel.text = Strings.onWeekdays
        weekdaysOptionLabel.font = UIFont.normalTextFont
        weekdaysOptionLabel.textColor = UIColor.textColor
        
    }
    
    @objc func radioButtonPressed(sender: RadioButton) {
        selectedOption = sender.tag
    }
    
    @objc func noIntervalDropdownPressed() {
        didSelectOption?(0)
        delegate?.showDropdown(sender: noIntervalDropdownButton)
    }
    
    @objc func intervalOptionDropdownPressed() {
        didSelectOption?(1)
        delegate?.showDropdown(sender: repeatWithIntervalOption.dropdownButton)
    }
}
