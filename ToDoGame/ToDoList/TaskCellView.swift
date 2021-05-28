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
    let tagsView = TagsView()
    
    var labelTopConstraint = NSLayoutConstraint()
    var labelBottomConstraint = NSLayoutConstraint()

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
        
        tagsView.tagsSelected = []
        tagsView.isUserInteractionEnabled = false
        
        checkButton.addTarget(self, action: #selector(checkButtonPressed), for: .touchUpInside)
    }
 
    func setupLayout() {
        setConstraints(on: roundedView, leading: 10, trailing: 10, top: 5, bottom: 5)
        roundedView.setConstraints(on: colorView, trailing: nil)
        colorView.widthAnchor.constraint(equalToConstant: 16).isActive = true
    
        roundedView.setConstraints(on: label, leading: 30, trailing: 70, top: nil, bottom: nil)
        labelTopConstraint = label.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 20)
        labelTopConstraint.isActive = true
        labelBottomConstraint = label.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: -50)
        labelBottomConstraint.isActive = true
        
//        roundedView.setConstraints(on: tagsView, leading: 10, trailing: 70, top: nil, bottom: 4)
//        tagsView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        roundedView.addSubview(checkButton)
        checkButton.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor).isActive = true
        checkButton.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -14).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        checkButton.widthAnchor.constraint(equalTo: checkButton.heightAnchor).isActive = true
    }
    
    func update(title: String, isDone: Bool, tags: [Tag]) {
        if isDone {
            let titleString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.strikethroughStyle : 1])
            label.attributedText = titleString
            label.layer.opacity = 0.7
        }
        else {
            label.attributedText = NSAttributedString(string: title)
            label.layer.opacity = 1.0
        }
        label.textColor = UIColor.textColor
        
        if tags.isEmpty {
            tagsView.isHidden = true
            labelTopConstraint.constant = 20
            labelBottomConstraint.constant = -20
        }
        else {
            tagsView.isHidden = false
            tagsView.tags = tags
            labelTopConstraint.constant = 20
            labelBottomConstraint.constant = -50
        }
        
        let buttonImageName = isDone ? "Round - on" : "Round - off"
        let buttonImage = UIImage(named: buttonImageName)
        checkButton.setImage(buttonImage, for: .normal)
        checkButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    
    
    @objc func checkButtonPressed() {
        buttonPressed?()
    }
    
}
