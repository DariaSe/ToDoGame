//
//  TimePickerView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 13.06.2021.
//

import UIKit

class TimePickerView: UIView {
    
    var isTimeSet: Bool = false {
        didSet {
            checkboxView.isCheckboxOn = isTimeSet
            UIView.animate(withDuration: 0.1) {
                self.checkboxView.timeButton.alpha = self.isTimeSet ? 1.0 : 0.0
            }
            if isTimePickerShown {
                isTimePickerShown = false
            }
        }
    }
    
    var date: Date = Date() {
        didSet {
            checkboxView.date = date
            timePickerView.date = date
        }
    }
    
    var isTimePickerShown: Bool = false {
        didSet {
            timePickerView.isHidden = !isTimePickerShown
            UIView.transition(with: timePickerView, duration: 0.2, options: [.transitionCrossDissolve]) {
                self.timePickerView.isHidden = !self.isTimePickerShown
                self.timePickerHeightConstraint.constant = self.isTimePickerShown ? 216 : 0
            }
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
        self.pinToEdges(subview: timePickerView, top: nil)
        checkboxView.bottomAnchor.constraint(equalTo: timePickerView.topAnchor).isActive = true
        timePickerHeightConstraint = timePickerView.heightAnchor.constraint(equalToConstant: 0)
        timePickerHeightConstraint.isActive = true
        timePickerView.isHidden = true
        checkboxView.timeButton.addTarget(self, action: #selector(timeButtonPressed), for: .touchUpInside)
        checkboxView.checkboxToggled = { [unowned self] in
            isTimeSet = !isTimeSet
        }
        timePickerView.datePickerMode = .time
        if #available(iOS 13.4, *) {
            timePickerView.preferredDatePickerStyle = .wheels
        }
        timePickerView.minuteInterval = 5
        timePickerView.addTarget(self, action: #selector(timePickerValueChanged), for: .valueChanged)
    }
    
    @objc func timeButtonPressed() {
        checkboxView.timeButton.animateScale(duration: 0.1, scale: 1.1)
        isTimePickerShown = !isTimePickerShown
    }
    
    @objc func timePickerValueChanged() {
        checkboxView.date = timePickerView.date
    }
}
