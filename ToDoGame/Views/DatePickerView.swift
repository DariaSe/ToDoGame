//
//  DatePickerView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 19.05.2021.
//

import UIKit

class DatePickerView: UIView {
    
    var labelText: String = "" {
        didSet {
            label.text = labelText
        }
    }
    
    var datePickerMode: UIDatePicker.Mode = .date {
        didSet {
            datePicker.datePickerMode = datePickerMode
        }
    }

    let stackView = UIStackView()
    
    let label = UILabel()
    let datePicker = UIDatePicker()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToLayoutMargins(subview: stackView, leading: 20, trailing: 20)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(datePicker)
        
        label.font = UIFont.normalTextFont
        label.textColor = UIColor.textColor
        
        datePicker.datePickerMode = datePickerMode
        datePicker.date = Date()
    }
}
