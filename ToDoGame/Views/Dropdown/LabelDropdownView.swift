//
//  LabelDropdownView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 19.05.2021.
//

import UIKit

class LabelDropdownView: UIView {
    
    var delegate: DropdownDelegate?
    
    var labelText: String = "" {
        didSet {
            label.text = labelText
        }
    }
    
    var buttonText: String = Strings.no {
        didSet {
            dropdownButton.text = buttonText
        }
    }
    
    let stackView = UIStackView()
    
    let label = UILabel()
    let dropdownButton = DropdownButton()

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
        stackView.addArrangedSubview(dropdownButton)
        label.font = UIFont.normalTextFont
        label.textColor = UIColor.textColor
        dropdownButton.addTarget(self, action: #selector(dropdownButtonPressed), for: .touchUpInside)
    }
    
    @objc func dropdownButtonPressed() {
        delegate?.showDropdown(sender: dropdownButton)
    }
}

protocol DropdownDelegate {
    func showDropdown(sender: UIButton)
}
