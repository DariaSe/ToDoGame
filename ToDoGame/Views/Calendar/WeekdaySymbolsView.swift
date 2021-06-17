//
//  WeekdaySymbolsView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 17.06.2021.
//

import UIKit

class WeekdaySymbolsView: UIView {
    
    let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabels()
    }
    
    func setupLabels() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        for day in Calendar.current.localWeekdaySymbols {
            let label = UILabel()
            label.text = day
            label.textAlignment = .center
            label.font = UIFont(name: nunitoRegular, size: 8)
            label.textColor = UIColor.textColor
            stackView.addArrangedSubview(label)
        }
    }
}
