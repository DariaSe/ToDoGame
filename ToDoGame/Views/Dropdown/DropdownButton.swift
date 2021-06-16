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
    
    private let stackView = UIStackView()
    
    private let label = UILabel()
    private let arrow = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToLayoutMargins(subview: stackView, leading: 5, trailing: 5, top: 2, bottom: 2)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(arrow)
        stackView.isUserInteractionEnabled = false
        label.text = text
        label.textColor = UIColor.buttonColor
        label.font = UIFont.normalTextFont
        label.isUserInteractionEnabled = false
        arrow.text = Strings.arrowDown
        arrow.textColor = UIColor.buttonColor
        arrow.isUserInteractionEnabled = false
    }
}
