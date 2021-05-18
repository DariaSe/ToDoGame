//
//  TaskListView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 24.04.2021.
//

import UIKit

class TaskListView: UIView {
    
    var tasks: [TaskViewModel] = [TaskViewModel(id: 1, orderID: 1, title: "Task 1", isDone: true, date: Date()), TaskViewModel(id: 2, orderID: 2, title: "Task 2", isDone: false, date: Date())]
    
    weak var delegate: TableViewCellDelegate?
    
    var tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.setConstraints(on: tableView, margins: true)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
    }
}

extension TaskListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell
        cell.delegate = self
        let task = tasks[indexPath.row]
        cell.update(title: task.title, isDone: task.isDone)
        return cell
    }
}

extension TaskListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
    }
}

extension TaskListView: TableViewCellDelegate {
    func checkButtonPressed() {
        
    }
}
