//
//  SingleTaskViewController.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 07.05.2021.
//

import UIKit

class SingleTaskViewController: UIViewController, KeyboardHandler {
    
    weak var coordinator: SingleTaskCoordinator?
    
    let scrollView = UIScrollView()
    
    let stackView = UIStackView()
    
    let topLabel = UILabel()
    let titleTextView = AppTextView()
    let datePickerView = DatePickerView()
    
    let tagsView = TagsView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        registerForKeyboardNotifications(for: titleTextView)
        
        view.setConstraints(on: scrollView, margins: true, top: 10, bottom: 20)
        scrollView.setConstraints(on: topLabel, margins: true, top: 30, bottom: nil)
        scrollView.setConstraints(on: stackView, top: 70)
        stackView.setWidth(equalTo: scrollView, multiplier: 0.98)
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.addArrangedSubview(titleTextView)
        stackView.addArrangedSubview(datePickerView)
        stackView.addArrangedSubview(tagsView)
        
        topLabel.text = "New task"
        topLabel.font = UIFont.screenTitleFont
        topLabel.textAlignment = .center
        titleTextView.heightAnchor.constraint(equalToConstant: SizeConstants.textFieldHeight).isActive = true
        titleTextView.text = "Task"
        datePickerView.labelText = "Date"
        tagsView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
