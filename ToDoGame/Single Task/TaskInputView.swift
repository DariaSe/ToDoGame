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
    let colorView = ColorComposedView()
    let notesTextViewContainer = TextViewContainer()
    
    var showTimeAlert: (() -> ())?

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
        datePickerView.didSelectDate = { [unowned self] date in
            var components = Calendar.current.dateComponents([.day, .month, .year], from: date)
            let hours = Calendar.current.component(.hour, from: timePickerView.date)
            let minutes = Calendar.current.component(.minute, from: timePickerView.date)
            components.hour = hours
            components.minute = minutes
            timePickerView.date = Calendar.current.date(from: components)!
        }
        repeatView.repeating = { [unowned self] isRepeating in
            datePickerView.label.text = isRepeating ? Strings.startDate : Strings.date
        }
        notificationView.didToggleCheckbox = { [unowned self] in
            if notificationView.isNotificationOn {
                notificationView.isNotificationOn = false
            }
            else {
                if timePickerView.isTimeSet {
                    notificationView.isNotificationOn = true
                }
                else {
                    showTimeAlert?()
                }
            }
        }
        setupEmptyTask()
    }
    
    func setupEmptyTask() {
        titleTextViewContainer.text = ""
        notesTextViewContainer.text = ""
    }
    
    
    func update(with task: Task) {
        titleTextViewContainer.text = task.title
        datePickerView.date = task.startDate
        timePickerView.isTimeSet = task.time != nil
        timePickerView.date = task.time == nil ? task.startDate.midday : task.startDate
        if let recurrenceRule = task.recurrenceRule {
            repeatView.isRepeating = true
            if let interval = recurrenceRule.interval, let frequency = recurrenceRule.recurrenceFrequency {
                repeatView.selectedRepeatingOption = interval == 1 ? 0 : 1
                repeatView.interval = interval
                repeatView.recurrenceFrequency = frequency
            }
            else if let weekdays = recurrenceRule.weekdays {
                repeatView.selectedRepeatingOption = 2
                repeatView.selectedWeekdays = weekdays
            }
        }
        else {
            repeatView.isRepeating = false
        }
        if let notificationOption = task.notificationOption {
            notificationView.isNotificationOn = true
            notificationView.notificationOption = notificationOption
        }
        if let color = task.color {
            colorView.isColorSet = true
            colorView.color = color
        }
        notesTextViewContainer.text = task.notes
    }
}
