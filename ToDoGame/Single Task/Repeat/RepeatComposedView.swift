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
            showHideUIElements()
        }
    }
    
    var selectedRepeatingOption: Int = 0 {
        didSet {
            repeatChoiceView.selectedOption = selectedRepeatingOption
        }
    }
    
    var selectedWeekdays: [Int] = [] {
        didSet {
            weekdaysView.selectedWeekdays = selectedWeekdays
        }
    }
    
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
        setupLayout()
        repeatCheckboxView.label.text = Strings.repeatt
        showHideUIElements()
        repeatCheckboxView.checkboxToggled = { [unowned self] in
            isRepeating = !isRepeating
        }
        repeatChoiceView.didSelectOption = { [unowned self] option in
            selectedRepeatingOption = option
        }
        weekdaysView.didSelectWeekday = { [unowned self] weekday in
            selectedRepeatingOption = 2
            if selectedWeekdays.contains(weekday) {
                selectedWeekdays = selectedWeekdays.filter { $0 != weekday }
            }
            else {
                selectedWeekdays.append(weekday)
            }
        }
    }
    
    func setupLayout() {
        self.pinToEdges(subview: repeatCheckboxView, bottom: nil)
        self.pinToEdges(subview: repeatChoiceView, top: nil, bottom: nil)
        repeatChoiceView.topAnchor.constraint(equalTo: repeatCheckboxView.bottomAnchor, constant: 10).isActive = true
        repeatChoiceViewHeightConstraint = repeatChoiceView.heightAnchor.constraint(equalToConstant: 200)
        repeatChoiceViewHeightConstraint.isActive = true
        self.pinToEdges(subview: weekdaysView, top: nil)
        repeatChoiceView.bottomAnchor.constraint(equalTo: weekdaysView.topAnchor, constant: 10).isActive = true
        weekdaysViewHeightConstraint = weekdaysView.heightAnchor.constraint(equalToConstant: 40)
        weekdaysViewHeightConstraint.isActive = true
    }
    
    func showHideUIElements() {
        repeatCheckboxView.isCheckboxOn = isRepeating
        repeatChoiceView.isHidden = !isRepeating
        weekdaysView.isHidden = !isRepeating
        repeatChoiceViewHeightConstraint.constant = isRepeating ? 200 : 0
        weekdaysViewHeightConstraint.constant = isRepeating ? 40 : 0
    }
}
