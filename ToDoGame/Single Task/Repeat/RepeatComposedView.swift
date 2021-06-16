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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToLayoutMargins(subview: repeatCheckboxView, bottom: nil)
        self.pinToLayoutMargins(subview: repeatChoiceView, top: nil)
        repeatChoiceView.topAnchor.constraint(equalTo: repeatCheckboxView.bottomAnchor, constant: 10).isActive = true
        repeatChoiceView.setDimensions(height: 150)
        repeatCheckboxView.label.text = Strings.repeatt
        setupUI()
        repeatCheckboxView.checkboxToggled = { [unowned self] in
            isRepeating = !isRepeating
        }
    }
    
    func setupUI() {
        repeatCheckboxView.isCheckboxOn = isRepeating
        repeatChoiceView.isHidden = !isRepeating
    }
}
