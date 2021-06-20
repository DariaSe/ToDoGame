//
//  TaskCellView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 27.05.2021.
//

import UIKit

class TaskCellView: UIView {
    
    var buttonPressed: (() -> Void)?
    
    let roundedView = UIView()
    
    let colorView = UIView()
    let label = UILabel()
    let checkButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        setupLayout()
        
        roundedView.backgroundColor = UIColor.backgroundColor
        roundedView.layer.cornerRadius = 16
        roundedView.layer.borderWidth = 1.0
        roundedView.layer.borderColor = UIColor.borderColor.cgColor
        roundedView.clipsToBounds = true
        
        colorView.backgroundColor = UIColor.tagColor(index: 2)
    
        checkButton.addTarget(self, action: #selector(checkButtonPressed), for: .touchUpInside)
    }
 
    func setupLayout() {
        self.pinToEdges(subview: roundedView, leading: 10, trailing: 10, top: 5, bottom: 5)
        roundedView.pinToEdges(subview: colorView, trailing: nil)
        
        colorView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        roundedView.pinToEdges(subview: label, leading: 30, trailing: 70, top: 24, bottom: 24)
        
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        roundedView.addSubview(checkButton)
        checkButton.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor).isActive = true
        checkButton.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -14).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        checkButton.widthAnchor.constraint(equalTo: checkButton.heightAnchor).isActive = true
    }
    
    func update(title: String, isDone: Bool, color: Int?) {
        if isDone {
            let titleString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.strikethroughStyle : 1])
            label.attributedText = titleString
            label.layer.opacity = 0.7
            checkButton.tintColor = UIColor.lightGray
        }
        else {
            label.attributedText = NSAttributedString(string: title)
            label.layer.opacity = 1.0
            checkButton.tintColor = UIColor.gray
        }
        label.textColor = UIColor.textColor
        label.font = UIFont.normalTextFont
        
        if let color = color {
            colorView.backgroundColor = UIColor.tagColor(index: color)
        }

        let buttonImageName = isDone ? "Round - on" : "Round - off"
        let buttonImage = UIImage(named: buttonImageName)?.withRenderingMode(.alwaysTemplate)
        checkButton.setImage(buttonImage, for: .normal)
        checkButton.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
    }
    
    
    
    @objc func checkButtonPressed() {
        buttonPressed?()
    }
    
}
