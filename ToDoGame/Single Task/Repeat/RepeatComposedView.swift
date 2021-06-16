//
//  RepeatComposedView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 13.06.2021.
//

import UIKit

class RepeatComposedView: UIView {
    
    var isRepeating: Bool = false {
        didSet {
            setupUI()
        }
    }
    let stackView = UIStackView()
    let repeatCheckboxView = CheckboxView()
    let repeatChoiceView = RepeatChoiceView()
    let weekdaysView = WeekdaysView()
    
    var repeatChoiceViewHeightConstraint = NSLayoutConstraint()
    var weekdaysViewHeightConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToEdges(subview: repeatCheckboxView, bottom: nil)
        self.pinToEdges(subview: repeatChoiceView, top: nil, bottom: nil)
        repeatChoiceView.topAnchor.constraint(equalTo: repeatCheckboxView.bottomAnchor, constant: 10).isActive = true
        repeatChoiceViewHeightConstraint = repeatChoiceView.heightAnchor.constraint(equalToConstant: 200)
        repeatChoiceViewHeightConstraint.isActive = true
//        repeatChoiceView.setDimensions(height: 200)
        self.pinToEdges(subview: weekdaysView, top: nil)
        repeatChoiceView.bottomAnchor.constraint(equalTo: weekdaysView.topAnchor, constant: 10).isActive = true
        weekdaysViewHeightConstraint = weekdaysView.heightAnchor.constraint(equalToConstant: 40)
        weekdaysViewHeightConstraint.isActive = true
//        weekdaysView.setDimensions(height: 40)
        repeatCheckboxView.label.text = Strings.repeatt
        setupUI()
        repeatCheckboxView.checkboxToggled = { [unowned self] in
            isRepeating = !isRepeating
        }
    }
    
    func setupUI() {
        repeatCheckboxView.isCheckboxOn = isRepeating
        repeatChoiceView.isHidden = !isRepeating
        weekdaysView.isHidden = !isRepeating
        repeatChoiceViewHeightConstraint.constant = isRepeating ? 200 : 0
        weekdaysViewHeightConstraint.constant = isRepeating ? 40 : 0
    }
}
