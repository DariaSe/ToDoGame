//
//  NotificationView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 18.06.2021.
//

import UIKit

class NotificationView: CheckboxView {
    
    var delegate: DropdownDelegate?
    
    var notificationOption: Int = 0 {
        didSet {
            dropdownButton.text = DropdownOptions.notificationOptions[notificationOption]
        }
    }
    
    var isNotificationOn: Bool = false {
        didSet {
            isCheckboxOn = isNotificationOn
            UIView.animate(withDuration: 0.1) {
                self.dropdownButton.alpha = self.isNotificationOn ? 1.0 : 0.0
            }
        }
    }
    
    let dropdownButton = DropdownButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initialSetup() {
        super.initialSetup()
        dropdownButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dropdownButton)
        dropdownButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 60).isActive = true
        dropdownButton.centerYAnchor.constraint(equalTo: checkboxButton.centerYAnchor).isActive = true
        dropdownButton.heightAnchor.constraint(equalToConstant: SizeConstants.buttonHeight).isActive = true
        label.text = Strings.notification
        dropdownButton.alpha = 0.0
        dropdownButton.text = DropdownOptions.notificationOptions[0]
        dropdownButton.addTarget(self, action: #selector(dropdownButtonPressed), for: .touchUpInside)
        checkboxToggled = {
            self.isNotificationOn = !self.isNotificationOn
        }
    }
    
    @objc func dropdownButtonPressed() {
        delegate?.showDropdown(sender: dropdownButton)
    }
}

