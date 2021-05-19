//
//  DropdownButton.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 19.05.2021.
//

import UIKit

class DropdownButton: UIButton {
    
    var text = Strings.no {
        didSet {
            label.text = text
        }
    }
    
    let stackView = UIStackView()
    
    let label = UILabel()
    let arrow = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        setConstraints(on: stackView, margins: true)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(arrow)
        label.textColor = UIColor.buttonColor
        arrow.text = Strings.arrowDown
        arrow.textColor = UIColor.buttonColor
    }
}
