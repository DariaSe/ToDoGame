//
//  SingleTaskViewController.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 07.05.2021.
//

import UIKit

class SingleTaskViewController: UIViewController, KeyboardHandler {
    
    weak var coordinator: SingleTaskCoordinator?
    
    var task: Task? {
        didSet {
            if let task = task {
                titleTextViewContainer.text = task.title
                datePickerView.datePicker.date = task.startDate
                let isTimeSet = task.notificationTime != nil
                timeDropdownView.buttonText = isTimeSet ? Strings.yes : Strings.no
                timeDropdownOption = isTimeSet ? 1 : 0
                timePickerView.isHidden = !isTimeSet
                let isRepeating = task.recurrenceRule != nil
                repeatDropdownView.buttonText = isRepeating ? Strings.yes : Strings.no
                repeatDropdownOption = isRepeating ? 1 : 0
                let isNotificationOn = task.isNotificationOn
                notificationDropdownView.buttonText = isNotificationOn ? Strings.year : Strings.no
                notificationDropdownOption = isNotificationOn ? 1 : 0
            }
        }
    }
    
    let scrollView = UIScrollView()
    
    let commonStackView = UIStackView()
    
    let topLabel = UILabel()
    let closeButton = UIButton()
    
    let titleTextViewContainer = TextViewContainer()
    let datePickerView = DatePickerView()
    let timeDropdownView = LabelDropdownView()
    let timePickerView = DatePickerView()
    let repeatDropdownView = LabelDropdownView()
    let notificationDropdownView = LabelDropdownView()
    
    let shadowingView = UIView()
    let dropdownMenu = DropdownView()
    
    var timeDropdownOption: Int = 1
    var repeatDropdownOption: Int = 1
    var notificationDropdownOption: Int = 1
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.backgroundColor
        registerForKeyboardNotifications(for: scrollView)
        
        view.pinToLayoutMargins(subview: scrollView, top: 10, bottom: 20)
        view.pinToLayoutMargins(subview: topLabel, top: 20, bottom: nil)
        view.pinToLayoutMargins(subview: closeButton, leading: nil, trailing: 2, top: 12, bottom: nil)
        scrollView.pinToEdges(subview: commonStackView, top: 70)
        commonStackView.setWidth(equalTo: scrollView)
        
        commonStackView.axis = .vertical
        commonStackView.spacing = 20
        commonStackView.addArrangedSubview(titleTextViewContainer)
        commonStackView.addArrangedSubview(datePickerView)
        commonStackView.addArrangedSubview(timeDropdownView)
        commonStackView.addArrangedSubview(timePickerView)
        commonStackView.addArrangedSubview(repeatDropdownView)
        
        commonStackView.addArrangedSubview(notificationDropdownView)
        
        
        view.pinToEdges(subview: shadowingView)
        shadowingView.isHidden = true
        shadowingView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        view.addSubview(dropdownMenu)
        dropdownMenu.isHidden = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMenu))
        shadowingView.addGestureRecognizer(tapRecognizer)
        
        topLabel.text = Strings.newTask
        topLabel.font = UIFont.screenTitleFont
        topLabel.textAlignment = .center
        
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor).isActive = true
        let closeImage = UIImage(named: "Cross")?.withRenderingMode(.alwaysTemplate)
        closeButton.setImage(closeImage, for: .normal)
        closeButton.tintColor = UIColor.black
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        
        titleTextViewContainer.heightAnchor.constraint(equalToConstant: SizeConstants.textFieldHeight).isActive = true
        titleTextViewContainer.placeholder = Strings.taskTitle
        
        datePickerView.labelText = Strings.date
        datePickerView.datePickerMode = .date
        
        timeDropdownView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        timeDropdownView.labelText = Strings.time
        timeDropdownView.delegate = self
        
        timePickerView.datePicker.datePickerMode = .time
        timePickerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        repeatDropdownView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        repeatDropdownView.labelText = Strings.repeatt
        repeatDropdownView.delegate = self
        
        setupEmptyTask()
    }
    
    func setupEmptyTask() {
        titleTextViewContainer.text = ""
        timePickerView.isHidden = true
    }
    
    
    @objc func closeButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissMenu() {
        dropdownMenu.isHidden = true
        shadowingView.isHidden = true
    }
    
    func frameForDropdown(sender: UIButton, height: CGFloat) -> CGRect {
        let senderOrigin = sender.convert(CGPoint.zero, to: self.view)
        let senderHeight = sender.frame.height
        let width = sender.bounds.width
        if (UIScreen.main.bounds.height - senderOrigin.y - 44) < height {
            return CGRect(x: senderOrigin.x, y: senderOrigin.y + senderHeight - height, width: width, height: height)
        }
        else {
            return CGRect(x: senderOrigin.x, y: senderOrigin.y, width: width, height: height)
        }
    }
}

extension SingleTaskViewController: DropdownDelegate {
    
    func showDropdown(sender: UIButton) {
        shadowingView.isHidden = false
        dropdownMenu.isHidden = false
        var options: [String]
        switch sender {
        case timeDropdownView.dropdownButton:
            options = DropdownOptions.yesOrNo
            dropdownMenu.selectedOption = timeDropdownOption
            dropdownMenu.didSelectOption = { [unowned self] option in
                dismissMenu()
                timeDropdownView.dropdownButton.text = options[option]
                timeDropdownOption = option
                timePickerView.isHidden = option == 1
            }
        case repeatDropdownView.dropdownButton:
            options = DropdownOptions.yesOrNo
            dropdownMenu.selectedOption = repeatDropdownOption
            dropdownMenu.didSelectOption = { [unowned self] option in
                dismissMenu()
                repeatDropdownView.dropdownButton.text = options[option]
                repeatDropdownOption = option
            }
        case notificationDropdownView.dropdownButton:
            options = DropdownOptions.yesOrNo
            dropdownMenu.selectedOption = notificationDropdownOption
            dropdownMenu.didSelectOption = { [unowned self] option in
                dismissMenu()
                notificationDropdownView.dropdownButton.text = options[option]
                notificationDropdownOption = option
            }
        default:
            options = DropdownOptions.noIntervalRecurrence
            dropdownMenu.didSelectOption = { [unowned self] option in
                dismissMenu()
                timeDropdownView.dropdownButton.text = options[option]
            }
        }
        let frame = frameForDropdown(sender: sender, height: CGFloat(44 * options.count))
        dropdownMenu.frame = frame
        dropdownMenu.options = options
    }
}
