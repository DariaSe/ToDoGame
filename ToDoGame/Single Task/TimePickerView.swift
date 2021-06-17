//
//  TimePickerView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 13.06.2021.
//

import UIKit

class TimePickerView: UIView {
    
    var isTimePickerShown: Bool = false {
        didSet {
            timePickerView.isHidden = !isTimePickerShown
            timePickerHeightConstraint.constant = isTimePickerShown ? 216 : 0
        }
    }
    
    let checkboxView = TimeCheckboxView()
    let timePickerView = UIDatePicker()
    
    var timePickerHeightConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToEdges(subview: checkboxView, bottom: nil)
        checkboxView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.pinToEdges(subview: timePickerView, top: nil)
        checkboxView.bottomAnchor.constraint(equalTo: timePickerView.topAnchor, constant: 10).isActive = true
        timePickerHeightConstraint = timePickerView.heightAnchor.constraint(equalToConstant: 0)
        timePickerHeightConstraint.isActive = true
        timePickerView.isHidden = true
        checkboxView.timeButton.addTarget(self, action: #selector(timeButtonPressed), for: .touchUpInside)
        timePickerView.datePickerMode = .time
        if #available(iOS 13.4, *) {
            timePickerView.preferredDatePickerStyle = .wheels
        }
        timePickerView.minuteInterval = 5
        timePickerView.addTarget(self, action: #selector(timePickerValueChanged), for: .valueChanged)
    }
    
    @objc func timeButtonPressed() {
        isTimePickerShown = !isTimePickerShown
    }
    
    @objc func timePickerValueChanged() {
        checkboxView.date = timePickerView.date
    }
}
