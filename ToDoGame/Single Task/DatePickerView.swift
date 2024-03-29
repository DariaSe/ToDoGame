//
//  DatePickerView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 19.05.2021.
//

import UIKit

class DatePickerView: UIView {
    
    var date: Date = Date() {
        didSet {
            dateButton.setTitle(date.formattedForHeader, for: .normal)
        }
    }
    
    var temporaryDate: Date = Date() {
        didSet {
            calendarHeaderView.title = temporaryDate.monthAndYear
            let selected = temporaryDate.belongsToMonth(of: date)
            calendarView.dataSource = CalendarService.makeCalendarDays(containing: temporaryDate, selected: selected)
        }
    }
    
    var isCalendarShown: Bool = false {
        didSet {
            calendarView.isCalendarShown = isCalendarShown
            isCalendarShown ? showCalendar() : hideCalendar()
        }
    }
    
    var didSelectDate: ((Date) -> ())?
    
    let label = UILabel()
    let dateButton = UIButton()
    let calendarHeaderView = CalendarHeaderView()
    let calendarView = CalendarCollectionView()
    
    var headerHeightConstraint = NSLayoutConstraint()
    var calendarHeightConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToEdges(subview: label, leading: 60, trailing: nil, top: 10, bottom: nil)
        dateButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dateButton)
        dateButton.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
        dateButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 80).isActive = true
        self.pinToEdges(subview: calendarHeaderView, leading: 40, trailing: 40, top: nil, bottom: nil)
        calendarHeaderView.topAnchor.constraint(equalTo: dateButton.bottomAnchor, constant: 5).isActive = true
        calendarHeaderView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        headerHeightConstraint = calendarHeaderView.heightAnchor.constraint(equalToConstant: 0)
        headerHeightConstraint.isActive = true
        calendarHeaderView.alpha = 0.0
        self.pinToEdges(subview: calendarView, leading: nil, trailing: nil, top: nil, bottom: 0)
        calendarView.topAnchor.constraint(equalTo: calendarHeaderView.bottomAnchor, constant: 10).isActive = true
        calendarView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        calendarView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        calendarHeightConstraint = calendarView.heightAnchor.constraint(equalToConstant: 0)
        calendarHeightConstraint.isActive = true
        calendarView.alpha = 0.0
        
        label.font = UIFont.normalTextFont
        label.textColor = UIColor.textColor
        label.text = Strings.date
        
        dateButton.setTitleColor(UIColor.buttonColor, for: .normal)
        dateButton.titleLabel?.font = UIFont.buttonFont
        dateButton.setTitle(date.formattedForHeader, for: .normal)
        dateButton.addTarget(self, action: #selector(dateButtonPressed), for: .touchUpInside)
        
        calendarHeaderView.delegate = self
        
        calendarView.didSelectDate = { [unowned self] newDate in
            didSelectDate?(newDate)
            date = newDate.dayStart
            temporaryDate = newDate.dayStart
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isCalendarShown = false
            }
        }
    }
    
    @objc func dateButtonPressed() {
        dateButton.animateScale(duration: 0.1, scale: 1.1)
        isCalendarShown = !isCalendarShown
    }
    
    func showCalendar() {
        headerHeightConstraint.constant = 50
        calendarHeaderView.alpha = 1.0
        adjustCalendarHeight()
        calendarHeaderView.title = date.monthAndYear
        calendarView.dataSource = CalendarService.makeCalendarDays(containing: date, selected: true)
    }
    
    func hideCalendar() {
        headerHeightConstraint.constant = 0
        calendarHeaderView.alpha = 0.0
        UIView.animate(withDuration: 0.2) {
            self.calendarHeightConstraint.constant = 0
            self.calendarView.alpha = 0.0
        }
        calendarHeaderView.title = date.formattedForHeader
    }
    
    func adjustCalendarHeight() {
        let numberOfWeeks = CalendarService.numberOfWeeksInMonth(containing: temporaryDate)
        let calendarHeight = CGFloat(40 * numberOfWeeks + 6 * (numberOfWeeks - 1) + 1 + 16)
        UIView.animate(withDuration: 0.2) {
            self.calendarHeightConstraint.constant = calendarHeight
            self.calendarView.alpha = 1.0
        }
    }
}

extension DatePickerView: CalendarDelegate {
    func setPrevious() {
        temporaryDate = Calendar.current.date(byAdding: .month, value: -1, to: temporaryDate)!
        adjustCalendarHeight()
    }
    
    func setNext() {
        temporaryDate = Calendar.current.date(byAdding: .month, value: 1, to: temporaryDate)!
        adjustCalendarHeight()
    }
    
    func titlePressed() {
        
    }
}
