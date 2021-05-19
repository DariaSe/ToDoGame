//
//  SingleTaskViewController.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 07.05.2021.
//

import UIKit

class SingleTaskViewController: UIViewController, KeyboardHandler {
    
    weak var coordinator: SingleTaskCoordinator?
    
    let stackView = UIStackView()
    
    let topLabel = UILabel()
    let titleTextView = AppTextView()
    let datePickerView = DatePickerView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
//        registerForKeyboardNotifications(for: titleTextView)
        view.setConstraints(on: topLabel, margins: true, top: 30, bottom: nil)
        view.setConstraints(on: stackView, margins: true, top: 70)
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.addArrangedSubview(titleTextView)
        stackView.addArrangedSubview(datePickerView)
        topLabel.text = "New task"
        topLabel.textAlignment = .center
        titleTextView.heightAnchor.constraint(equalToConstant: SizeConstants.textFieldHeight).isActive = true
        titleTextView.text = "Task"
        datePickerView.labelText = "Date"
    }
}
