//
//  RadioSwitchTableViewCell.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 16.06.2021.
//

import UIKit

class RadioSwitchTableViewCell: UITableViewCell {
    
    let radioButton = RadioButton()
    
    var didSelectOption: (() -> ())?
    
    static let reuseIdentifier = "RadioSwitchCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup() {
        contentView.pinToLayoutMargins(subview: radioButton, trailing: nil, bottom: nil)
        radioButton.setDimensions(width: 40, height: 40)
        radioButton.addTarget(self, action: #selector(didSelectOption(sender:)), for: .touchUpInside)
    }
    
    func update(with view: UIView, isSelected: Bool) {
        radioButton.isSelected = isSelected
        contentView.pinToLayoutMargins(subview: view, leading: 60, trailing: 0)
    }
    
    @objc func didSelectOption(sender: UIButton) {
        didSelectOption?()
    }
}
