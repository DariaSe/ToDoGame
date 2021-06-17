//
//  CalendarService.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 17.06.2021.
//

import Foundation

class CalendarService {
    
    static func makeCalendarDays(containing date: Date) -> [CalendarDay] {
        let dates = Calendar.current.extendedMonth(containing: date)
        let calendarDates = dates.map { (arrayDate) -> CalendarDay in
            let number = Calendar.current.component(.day, from: arrayDate)
            let belongsToMonth = arrayDate.belongsToMonth(of: date)
            let isSelected = arrayDate.dayStart == date.dayStart
            return CalendarDay(number: number, belongsToMonth: belongsToMonth, isSelected: isSelected)
        }
        return calendarDates
    }
}
