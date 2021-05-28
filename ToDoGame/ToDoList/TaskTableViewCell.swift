//
//  TaskTableViewCell.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 24.04.2021.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ToDoListCell"
    
    let taskView = TaskCellView()
    let placeholderView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        contentView.backgroundColor = .clear
        contentView.setConstraints(on: placeholderView, leading: 10, trailing: 10, top: 5, bottom: 5)
        placeholderView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        placeholderView.layer.cornerRadius = 16
        placeholderView.isHidden = true
        contentView.setConstraints(on: taskView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let view = UIView()
        view.frame = contentView.bounds
        view.backgroundColor = .clear
        selectedBackgroundView = view
    }

}
