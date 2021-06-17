//
//  RepeatChoiceView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 16.06.2021.
//

import UIKit

class RepeatChoiceView: RadioSwitchTableView {
    
    var delegate: DropdownDelegate?
    
    let dailyOptionDropdown = DropdownButton()
    let repeatWithIntervalOption = RepeatWithIntervalView()
    let weekdaysOptionLabel = UILabel()
    
    var firstOptionWidthConstraint = NSLayoutConstraint()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initialSetup() {
        super.initialSetup()
        dailyOptionDropdown.text = Strings.daily
        dailyOptionDropdown.addTarget(self, action: #selector(dailyOptionDropdownPressed), for: .touchUpInside)
        repeatWithIntervalOption.dropdownButton.addTarget(self, action: #selector(intervalOptionDropdownPressed), for: .touchUpInside)
        repeatWithIntervalOption.textDidChange = { [unowned self] in
            didSelectOption?(1)
        }
        weekdaysOptionLabel.text = Strings.onWeekdays
        weekdaysOptionLabel.font = UIFont.normalTextFont
        weekdaysOptionLabel.textColor = UIColor.textColor
        let weekdaysOptionView = UIView()
        weekdaysOptionView.pinToLayoutMargins(subview: weekdaysOptionLabel, leading: -10)
        options = [dailyOptionDropdown, repeatWithIntervalOption, weekdaysOptionView]
    }
    
    @objc func dailyOptionDropdownPressed() {
        didSelectOption?(0)
        delegate?.showDropdown(sender: dailyOptionDropdown)
    }
    
    @objc func intervalOptionDropdownPressed() {
        didSelectOption?(1)
        delegate?.showDropdown(sender: repeatWithIntervalOption.dropdownButton)
    }
}
