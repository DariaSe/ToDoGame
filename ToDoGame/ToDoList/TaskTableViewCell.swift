//
//  TaskTableViewCell.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 24.04.2021.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ToDoListCell"
    
    weak var delegate: TableViewCellDelegate?
    
    lazy var label = UILabel()
    lazy var checkButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        contentView.setConstraints(on: label, margins: true, trailing: 70)
        contentView.setConstraints(on: checkButton, margins: true, leading: nil)
        checkButton.widthAnchor.constraint(equalTo: checkButton.heightAnchor).isActive = true
        checkButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    func update(title: String, isDone: Bool) {
        
        self.label.text = title
        let buttonImageName = isDone ? "Checked" : "Unchecked"
        let buttonImage = UIImage(named: buttonImageName)
        checkButton.setImage(buttonImage, for: .normal)
        
    }
    
    @objc func buttonPressed() {
        delegate?.checkButtonPressed()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
