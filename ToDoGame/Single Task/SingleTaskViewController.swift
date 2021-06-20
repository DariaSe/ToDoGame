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
                topLabel.text = Strings.task
                taskInputView.update(with: task)
            }
        }
    }
    
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
        deleteButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20).isActive = true
        deleteButton.setDimensions(height: SizeConstants.buttonHeight)
        deleteButton.titleLabel?.font = UIFont.buttonFont
        deleteButton.setTitle(Strings.deleteTask, for: .normal)
        deleteButton.setTitleColor(UIColor.destructiveColor, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        
        view.pinToEdges(subview: shadowingView)
        shadowingView.isHidden = true
        shadowingView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        view.addSubview(dropdownMenu)
        dropdownMenu.isHidden = true
        
        scrollView.delegate = self
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMenu))
        shadowingView.addGestureRecognizer(tapRecognizer)
        
        topLabel.text = Strings.newTask
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
    }
    
    @objc func deleteButtonPressed() {
        deleteButton.animateScale(duration: 0.1, scale: 1.1)
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

extension SingleTaskViewController: DropdownDelegate {
    
    var noIntervalDropdown: DropdownButton { taskInputView.repeatView.repeatChoiceView.noIntervalDropdownButton }
    
    var intervalDropdown: DropdownButton { taskInputView.repeatView.repeatChoiceView.repeatWithIntervalOption.dropdownButton }
    var interval: Int { taskInputView.repeatView.repeatChoiceView.repeatWithIntervalOption.interval}
    
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
