//
//  CalendarService.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 17.06.2021.
//

import Foundation

class CalendarService {
    
    static func makeCalendarDays(containing date: Date, selected: Bool) -> [CalendarDay] {
        let dates = Calendar.current.extendedMonth(containing: date)
        let calendarDays = dates.map { (arrayDate) -> CalendarDay in
            let belongsToMonth = arrayDate.belongsToMonth(of: date)
            let isSelected = (arrayDate.dayStart == date.dayStart) && selected
            return CalendarDay(date: arrayDate, belongsToMonth: belongsToMonth, isSelected: isSelected)
        }
        return calendarDays
    }
    
    static func numberOfWeeksInMonth(containing date: Date) -> Int {
        let dates = Calendar.current.extendedMonth(containing: date)
        return Int(ceil(Double(dates.count) / 7.0))
    }
}
