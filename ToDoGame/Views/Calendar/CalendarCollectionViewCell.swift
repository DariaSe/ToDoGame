//
//  CalendarCollectionViewCell.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 17.06.2021.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CalendarCell"
    
    let label = UILabel()
    let circle = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        contentView.pinToEdges(subview: circle)
        label.center(in: contentView)
        circle.layer.cornerRadius = 20
        circle.layer.backgroundColor = UIColor.TagColors.green.cgColor
        label.font = UIFont(name: nunitoSemiBold, size: 16)
    }
    
    func update(with calendarDay: CalendarDay) {
        let number = Calendar.current.component(.day, from: calendarDay.date)
        label.text = number.string
        circle.isHidden = !calendarDay.isSelected
        if calendarDay.isSelected {
            label.isHidden = false
            label.textColor = UIColor.white
            return
        }
        if calendarDay.belongsToMonth {
            label.isHidden = false
            label.textColor = UIColor.textColor
        }
        else {
            label.isHidden = true
        }
    }
}
