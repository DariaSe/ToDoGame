//
//  CheckboxView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 16.06.2021.
//

import UIKit

class CheckboxView: UIView {
    
    var isCheckboxOn: Bool = true {
        didSet {
            checkboxButton.isSelected = isCheckboxOn
            label.textColor = isCheckboxOn ? UIColor.textColor : UIColor.textColor.withAlphaComponent(0.5)
        }
    }
    
    var checkboxToggled: (() -> ())?
    
    let stackView = UIStackView()
    
    let checkboxButton = CheckboxButton()
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup() {
        self.pinToLayoutMargins(subview: stackView)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.addArrangedSubview(checkboxButton)
        stackView.addArrangedSubview(label)
        checkboxButton.setDimensions(width: 40, height: 40)
        checkboxButton.addTarget(self, action: #selector(didToggleCheckbox), for: .touchUpInside)
        checkboxButton.isSelected = isCheckboxOn
        label.textColor = isCheckboxOn ? UIColor.textColor : UIColor.textColor.withAlphaComponent(0.5)
    }
    
    @objc func didToggleCheckbox() {
//        isCheckboxOn = !isCheckboxOn
        checkboxToggled?()
    }
}
