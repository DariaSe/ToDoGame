//
//  TaskInputView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 13.06.2021.
//

import UIKit

class TaskInputView: UIView {
    
    let commonStackView = UIStackView()
    
    let titleTextViewContainer = TextViewContainer()
    let datePickerView = DatePickerView()
    let timePickerView = TimePickerView()
    let repeatView = RepeatComposedView()
    
    var timeDropdownOption: Int = 1
    var repeatDropdownOption: Int = 1
    var notificationDropdownOption: Int = 1

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToEdges(subview: commonStackView)
        commonStackView.axis = .vertical
        commonStackView.spacing = 20
        commonStackView.addArrangedSubview(titleTextViewContainer)
        commonStackView.addArrangedSubview(datePickerView)
        commonStackView.addArrangedSubview(timePickerView)
        commonStackView.addArrangedSubview(repeatView)

        
        titleTextViewContainer.heightAnchor.constraint(equalToConstant: SizeConstants.textFieldHeight).isActive = true
        titleTextViewContainer.placeholder = Strings.taskTitle
        
        setupEmptyTask()
    }
    
    func setupEmptyTask() {
        titleTextViewContainer.text = ""
    }
    
    
    func update(with task: Task) {
        titleTextViewContainer.text = task.title
//        datePickerView.datePicker.date = task.startDate
        let isTimeSet = task.notificationTime != nil
//        timeDropdownView.buttonText = isTimeSet ? Strings.yes : Strings.no
        timeDropdownOption = isTimeSet ? 1 : 0
        timePickerView.isHidden = !isTimeSet
        let isRepeating = task.recurrenceRule != nil
        repeatDropdownOption = isRepeating ? 1 : 0
        let isNotificationOn = task.isNotificationOn
//        notificationDropdownView.buttonText = isNotificationOn ? Strings.yes : Strings.no
        notificationDropdownOption = isNotificationOn ? 1 : 0
    }
}
