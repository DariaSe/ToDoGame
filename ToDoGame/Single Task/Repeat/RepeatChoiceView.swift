//
//  RepeatChoiceView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 16.06.2021.
//

import UIKit

class RepeatChoiceView: RadioSwitchTableView {
    
    let firstOption = DropdownButton()
    let secondOption = RepeatWithIntervalView()
    let thirdOptionLabel = UILabel()
    
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
        firstOption.text = Strings.daily
        thirdOptionLabel.text = Strings.onWeekdays
        thirdOptionLabel.font = UIFont.normalTextFont
        thirdOptionLabel.textColor = UIColor.textColor
        let thirdOptionView = UIView()
        thirdOptionView.pinToLayoutMargins(subview: thirdOptionLabel, leading: -10)
        options = [firstOption, secondOption, thirdOptionView]
    }
}
