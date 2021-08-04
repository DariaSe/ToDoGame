//
//  ToDoListViewController.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 24.04.2021.
//

import UIKit

class TaskListViewController: UIViewController, ErrorPresenter {
    
    weak var coordinator: TaskListCoordinator?
    
    var tasks: [TaskViewModel] = [] {
        didSet {
            taskListView.tasks = tasks
        }
    }
    
    var date: Date = Date() {
        didSet {
            coordinator?.date = date
            calendarHeaderView.title = date.formattedForHeader
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
    
    var emptyMessageView = UIView()
    
    var calendarHeaderView = CalendarHeaderView()
    var calendarView = CalendarCollectionView()
    var calendarHeightConstraint = NSLayoutConstraint()
    
    var addButton = UIButton()
    let plusImage = UIImage(named: "Plus")?.withRenderingMode(.alwaysTemplate)
    
    let gamificationOverview = GamificationOverviewView()
    
    var taskListView = TaskListView()
    var errorView = WarningView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        view.pinToLayoutMargins(subview: calendarHeaderView, leading: 30, trailing: 30, top: 0, bottom: nil)
        calendarHeaderView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.pinToLayoutMargins(subview: addButton, leading: nil, trailing: -10, bottom: nil)
        addButton.setDimensions(width: 50, height: 50)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendarView)
        view.pinToLayoutMargins(subview: gamificationOverview, top: nil, bottom: nil)
        calendarView.topAnchor.constraint(equalTo: calendarHeaderView.bottomAnchor, constant: 10).isActive = true
        calendarView.bottomAnchor.constraint(equalTo: gamificationOverview.topAnchor, constant: 10).isActive = true
        view.pinToEdges(subview: taskListView, top: nil)
        gamificationOverview.bottomAnchor.constraint(equalTo: taskListView.topAnchor).isActive = true
        calendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        calendarView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        calendarHeightConstraint = calendarView.heightAnchor.constraint(equalToConstant: 0)
        calendarHeightConstraint.isActive = true
        calendarView.alpha = 0.0
        
        calendarHeaderView.delegate = self
        calendarHeaderView.title = date.formattedForHeader
        
        addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        addButton.setImage(plusImage, for: .normal)
        addButton.tintColor = UIColor.buttonColor
        
        calendarView.didSelectDate = { [unowned self] newDate in
            date = newDate
            temporaryDate = newDate
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isCalendarShown = false
            }
        }
        
        taskListView.setCompletedOrCancel = { [unowned self] taskID in
            coordinator?.setCompletedOrCancel(taskID: taskID)
        }
        taskListView.deleteTask = { [unowned self] taskID in
            coordinator?.askForDeletion(taskID: taskID)
        }
        taskListView.didSelectTask = { [unowned self] taskID in
            coordinator?.openTask(id: taskID)
        }
        
        setupErrorView()
    }
    
    @objc func addTask() {
        coordinator?.showAddTaskScreen(date: date)
    }
    
    func showCalendar() {
        calendarView.isHidden = false
        adjustCalendarHeight()
        calendarHeaderView.title = date.monthAndYear
        calendarView.dataSource = CalendarService.makeCalendarDays(containing: date, selected: true)
    }
    
    func hideCalendar() {
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

extension TaskListViewController: CalendarDelegate {
    
    func setPrevious() {
        if isCalendarShown {
            temporaryDate = Calendar.current.date(byAdding: .month, value: -1, to: temporaryDate)!
            adjustCalendarHeight()
        }
        else {
            date = date.yesterday
        }
    }
    
    func setNext() {
        if isCalendarShown {
            temporaryDate = Calendar.current.date(byAdding: .month, value: 1, to: temporaryDate)!
            adjustCalendarHeight()
        }
        else {
            date = date.tomorrow
        }
    }
    
    func titlePressed() {
        isCalendarShown = !isCalendarShown
        if isCalendarShown {
            calendarView.dataSource = CalendarService.makeCalendarDays(containing: date, selected: true)
            temporaryDate = date
        }
    }
}
