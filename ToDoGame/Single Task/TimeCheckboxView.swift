//
//  TimeCheckboxView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 17.06.2021.
//

import UIKit

class TimeCheckboxView: CheckboxView {

    var date: Date = Date() {
        didSet {
            setTimeButtonTitle()
        }
    }
    
    let timeButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initialSetup() {
        super.initialSetup()
        timeButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(timeButton)
        timeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 40).isActive = true
        timeButton.centerYAnchor.constraint(equalTo: checkboxButton.centerYAnchor).isActive = true
        label.text = Strings.time
        timeButton.setTitleColor(UIColor.buttonColor, for: .normal)
        timeButton.titleLabel?.font = UIFont.buttonFont
        setTimeButtonTitle()
    }
    
    func setTimeButtonTitle() {
        let dateformatter = DateFormatter()
        dateformatter.timeStyle = .short
        dateformatter.dateStyle = .none
        let time = dateformatter.string(from: date)
        timeButton.setTitle(time, for: .normal)
    }
}
