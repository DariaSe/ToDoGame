//
//  TaskInputView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 13.06.2021.
//

import UIKit

class TaskInputView: UIView {
   
    let titleTextViewContainer = TextViewContainer()
    let datePickerView = DatePickerView()
    let timePickerView = TimePickerView()
    let repeatView = RepeatComposedView()
    let notificationView = NotificationView()
    let colorView = ColorView()
    let notesTextViewContainer = TextViewContainer()
    
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
        self.pinToEdges(subview: titleTextViewContainer, bottom: nil)
        self.pinToEdges(subview: datePickerView, top: nil, bottom: nil)
        self.pinToEdges(subview: timePickerView, top: nil, bottom: nil)
        self.pinToEdges(subview: repeatView, top: nil, bottom: nil)
        self.pinToEdges(subview: notificationView, top: nil, bottom: nil)
        self.pinToEdges(subview: colorView, top: nil, bottom: nil)
        self.pinToEdges(subview: notesTextViewContainer, top: nil)

        titleTextViewContainer.bottomAnchor.constraint(equalTo: datePickerView.topAnchor, constant: -20).isActive = true
        datePickerView.bottomAnchor.constraint(equalTo: timePickerView.topAnchor, constant: 0).isActive = true
        timePickerView.bottomAnchor.constraint(equalTo: repeatView.topAnchor, constant: -10).isActive = true
        repeatView.bottomAnchor.constraint(equalTo: notificationView.topAnchor, constant: -10).isActive = true
        notificationView.bottomAnchor.constraint(equalTo: colorView.topAnchor, constant: -10).isActive = true
        colorView.bottomAnchor.constraint(equalTo: notesTextViewContainer.topAnchor, constant: -20).isActive = true
        
        titleTextViewContainer.placeholder = Strings.taskTitle
        notesTextViewContainer.placeholder = Strings.notes
        setupEmptyTask()
    }
    
    func setupEmptyTask() {
        titleTextViewContainer.text = ""
        notesTextViewContainer.text = ""
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
