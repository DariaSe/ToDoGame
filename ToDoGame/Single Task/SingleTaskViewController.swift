//
//  SingleTaskViewController.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 07.05.2021.
//

import UIKit

class SingleTaskViewController: UIViewController, KeyboardHandler {
    
    weak var coordinator: TaskListCoordinator?
    
    var task: Task? {
        didSet {
            if let task = task {
                taskInputView.update(with: task)
                if let recurrenceRule = task.recurrenceRule {
                    if let interval = recurrenceRule.interval, let frequency = recurrenceRule.recurrenceFrequency {
                        if interval == 1 {
                            noIntervalDropdownOption = frequency.rawValue
                        }
                        else {
                            intervalDropdownOption = frequency.rawValue
                        }
                    }
                }
                if let notificationOption = task.notificationOption {
                    notificationDropdownOption = notificationOption
                }
            }
        }
    }
    
    var selectedDate: Date = Date() {
        didSet {
            taskInputView.datePickerView.date = selectedDate
        }
    }
    
    var nextID: Int?
    var nextOrderID: Int?
    
    //MARK: - UI Elements
    
    let topLabel = UILabel()
    let closeButton = UIButton()
    
    let scrollView = UIScrollView()
    let containerView = UIView()
    
    let taskInputView = TaskInputView()
    
    let saveButton = UIButton()
    let deleteButton = UIButton()

    let shadowingView = UIView()
    let dropdownMenu = DropdownView()
    
    var noIntervalDropdownOption: Int = 0
    var intervalDropdownOption: Int = 0
    var notificationDropdownOption: Int = 0
    
    let tap = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.backgroundColor
        registerForKeyboardNotifications(for: scrollView)
        
        view.pinToLayoutMargins(subview: scrollView)
        scrollView.pinToEdges(subview: containerView)
        containerView.pinToLayoutMargins(subview: topLabel, top: 10, bottom: nil)
        containerView.pinToLayoutMargins(subview: closeButton, leading: nil, trailing: -10, top: 2, bottom: nil)
        containerView.pinToEdges(subview: taskInputView, top: nil, bottom: nil)
        taskInputView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20).isActive = true
        taskInputView.setWidth(equalTo: scrollView)
        taskInputView.showTimeAlert = { [unowned self] in
            let alert = UIAlertController.simpleAlert(title: Strings.setTimeAlert, message: nil, handler: nil)
            self.present(alert, animated: true, completion: nil)
        }
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(saveButton)
        saveButton.topAnchor.constraint(equalTo: taskInputView.bottomAnchor, constant: 20).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.setDimensions(width: 100, height: SizeConstants.buttonHeight)
        saveButton.layer.cornerRadius = SizeConstants.buttonCornerRadius
        saveButton.backgroundColor = UIColor.buttonColor
        saveButton.titleLabel?.font = UIFont.buttonFont
        saveButton.setTitle(Strings.save, for: .normal)
        saveButton.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(deleteButton)
        deleteButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 10).isActive = true
        deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20).isActive = true
        deleteButton.setDimensions(height: SizeConstants.buttonHeight)
        deleteButton.titleLabel?.font = UIFont.buttonFont
        deleteButton.setTitle(Strings.deleteTask, for: .normal)
        deleteButton.setTitleColor(UIColor.destructiveColor, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        deleteButton.isHidden = task == nil
        
        view.pinToEdges(subview: shadowingView)
        shadowingView.isHidden = true
        shadowingView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        view.addSubview(dropdownMenu)
        dropdownMenu.isHidden = true
        
        scrollView.delegate = self
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMenu))
        shadowingView.addGestureRecognizer(tapRecognizer)
        
        topLabel.text = (task == nil) ? Strings.newTask : Strings.task
        topLabel.font = UIFont.screenTitleFont
        topLabel.textAlignment = .center
        
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor).isActive = true
        let closeImage = UIImage(named: "Cross")?.withRenderingMode(.alwaysTemplate)
        closeButton.setImage(closeImage, for: .normal)
        closeButton.tintColor = UIColor.buttonColor
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
      
        setupDelegates()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // cash here unsaved task
    }
    
    @objc func closeButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonPressed() {
        saveButton.animateScale(duration: 0.1, scale: 1.1)
        saveTask()
    }
    
    @objc func deleteButtonPressed() {
        deleteButton.animateScale(duration: 0.1, scale: 1.1)
        guard let task = task else { return }
        coordinator?.askForDeletion(taskID: task.id)
    }
    
    @objc func dismissMenu() {
        dropdownMenu.isHidden = true
        shadowingView.isHidden = true
    }
}

extension SingleTaskViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

//MARK: - DropdownDelegate

extension SingleTaskViewController: DropdownDelegate {
    
    var noIntervalDropdown: DropdownButton { taskInputView.repeatView.repeatChoiceView.noIntervalDropdownButton }
    
    var intervalDropdown: DropdownButton { taskInputView.repeatView.repeatChoiceView.repeatWithIntervalOption.dropdownButton }
    
    var notificationDropdown: DropdownButton {
        taskInputView.notificationView.dropdownButton }
    
    func setupDelegates() {
        taskInputView.repeatView.repeatChoiceView.delegate = self
        taskInputView.notificationView.delegate = self
    }

    func showDropdown(sender: UIButton) {
        shadowingView.isHidden = false
        dropdownMenu.isHidden = false
        var options: [String] = []
        switch sender {
        case noIntervalDropdown:
            options = DropdownOptions.noIntervalRecurrence
            dropdownMenu.selectedOption = noIntervalDropdownOption
            dropdownMenu.didSelectOption = { [unowned self] option in
                dismissMenu()
                noIntervalDropdown.text = options[option]
                noIntervalDropdownOption = option
            }
        case intervalDropdown:
            options = DropdownOptions.intervalRecurrence(interval: interval)
            dropdownMenu.selectedOption = intervalDropdownOption
            dropdownMenu.didSelectOption = { [unowned self] option in
                dismissMenu()
                intervalDropdown.text = options[option]
                intervalDropdownOption = option
            }
        case notificationDropdown:
            options = DropdownOptions.notificationOptions
            dropdownMenu.selectedOption = notificationDropdownOption
            dropdownMenu.didSelectOption = { [unowned self] option in
                dismissMenu()
                notificationDropdown.text = options[option]
                notificationDropdownOption = option
            }
        default:
            break
        }
        let frame = frameForDropdown(sender: sender, height: CGFloat(44 * options.count))
        dropdownMenu.frame = frame
        dropdownMenu.options = options
    }
    
    func frameForDropdown(sender: UIButton, height: CGFloat) -> CGRect {
        let senderOrigin = sender.convert(CGPoint.zero, to: self.view)
        let senderHeight = sender.frame.height
        let width = sender.bounds.width + 30
        if (UIScreen.main.bounds.height - senderOrigin.y - 44) < height {
            return CGRect(x: senderOrigin.x, y: senderOrigin.y + senderHeight - height, width: width, height: height)
        }
        else {
            return CGRect(x: senderOrigin.x, y: senderOrigin.y, width: width, height: height)
        }
    }
}
// MARK: - Saving

extension SingleTaskViewController {
    
    var taskTitle: String { taskInputView.titleTextViewContainer.textView.text }
    var startDate: Date { taskInputView.datePickerView.date }
    var isTimeSet: Bool { taskInputView.timePickerView.isTimeSet }
    var timeDate: Date { taskInputView.timePickerView.checkboxView.date }
    var isRepeating: Bool { taskInputView.repeatView.isRepeating }
    var repeatingOption: Int { taskInputView.repeatView.selectedRepeatingOption }
    var interval: Int { taskInputView.repeatView.repeatChoiceView.repeatWithIntervalOption.interval }
    var weekdays: [Int] { taskInputView.repeatView.selectedWeekdays }
    var isNotificationOn: Bool { taskInputView.notificationView.isNotificationOn }
    var isColorSet: Bool { taskInputView.colorView.isColorSet }
    var color: Int { taskInputView.colorView.color }
    var notes: String { taskInputView.notesTextViewContainer.textView.text }
    
    func saveTask() {
        guard !taskTitle.isEmpty && taskTitle != Strings.taskTitle else {
            let warning = UIAlertController.simpleAlert(title: Strings.emptyTitleAlert, message: nil, handler: nil)
            self.present(warning, animated: true, completion: nil)
            return
        }
        let date = isTimeSet ? timeDate : startDate.dayStart
        var recurrenceRule: RecurrenceRule?
        if isRepeating {
            switch repeatingOption {
            case 0:
                let frequency = RecurrenceFrequency.init(rawValue: noIntervalDropdownOption)
                recurrenceRule = RecurrenceRule(recurrenceFrequency: frequency, interval: 1, weekdays: nil)
            case 1:
                let frequency = RecurrenceFrequency.init(rawValue: intervalDropdownOption)
                recurrenceRule = RecurrenceRule(recurrenceFrequency: frequency, interval: interval, weekdays: nil)
            case 2:
                recurrenceRule = RecurrenceRule(recurrenceFrequency: nil, interval: nil, weekdays: weekdays)
            default: break
            }
        }
        let notificationOption = isNotificationOn ? notificationDropdownOption : nil
        var newColor: Int?
        if isColorSet {
            UserDefaultsService.lastColor = color
            newColor = color
        }
        if let task = task {
            let editedTask = Task(id: task.id, orderID: task.orderID, title: taskTitle, startDate: date, recurrenceRule: recurrenceRule, executionLog: task.executionLog, notificationOption: notificationOption, color: newColor, notes: notes)
            coordinator?.save(task: editedTask)
            self.dismiss(animated: true, completion: nil)
        }
        else {
            guard let nextID = nextID, let nextOrderID = nextOrderID else { return }
            let newTask = Task(id: nextID, orderID: nextOrderID, title: taskTitle, startDate: date, recurrenceRule: recurrenceRule, executionLog: [], notificationOption: notificationOption, color: newColor, notes: notes)
            coordinator?.save(task: newTask)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
