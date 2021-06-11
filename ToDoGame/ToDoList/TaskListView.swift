//
//  TaskListView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 24.04.2021.
//

import UIKit

class TaskListView: UIView {
    
    var swapDelegate: SwapDelegate?
    
    var tasksManager = TasksManager()
    
    var tasks: [TaskViewModel] = [] {
        didSet {
            tasksManager.tasks = tasks
            tableView.reloadData()
        }
    }
 
    var setCompletedOrCancel: ((Int) -> Void)?
    var deleteTask: ((Int) -> Void)?
    
    var tableView = UITableView(frame: CGRect.zero, style: .grouped)
    var snapshotView = UIImageView()
    
    let longPressRecognizer = UILongPressGestureRecognizer()
    var sourceIndexPath: IndexPath?
    var firstTaskID: Int?
    var secondTaskID: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.setConstraints(on: tableView)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        tableView.addGestureRecognizer(longPressRecognizer)
        longPressRecognizer.minimumPressDuration = 0.5
        longPressRecognizer.addTarget(self, action: #selector(handleLongPressGesture(_:)))
        tableView.addSubview(snapshotView)
    }
    
    @objc func handleLongPressGesture(_ recognizer: UILongPressGestureRecognizer) {
        
        let location = recognizer.location(in: tableView)
        let newIndexPath = tableView.indexPathForRow(at: location)
        
        guard let indexPath = newIndexPath else {
            recognizer.cancel()
            snapshotView.transform = CGAffineTransform.identity
            let cell = tableView.cellForRow(at: sourceIndexPath!) as! TaskTableViewCell
            cell.taskView.isHidden = false
            cell.placeholderView.isHidden = true
            snapshotView.frame = CGRect.zero
            return
        }
        
        switch recognizer.state {
        case .began:
            guard indexPath.section != 1 else {
                recognizer.cancel()
                return
            }
            tableView.bringSubviewToFront(snapshotView)
            sourceIndexPath = indexPath
            let task = tasksManager.activeTasks[indexPath.row]
            firstTaskID = task.id
            let cell = self.tableView.cellForRow(at: indexPath) as! TaskTableViewCell
            let snapshot = cell.snapshot
            snapshotView.image = snapshot
            snapshotView.frame = cell.frame
            UIView.animate(withDuration: 0.1) {
                self.snapshotView.transform = CGAffineTransform(rotationAngle: 0.05)
            }
            cell.taskView.isHidden = true
            cell.placeholderView.isHidden = false
            
        case .changed:
            guard indexPath.section != 1 else {
                recognizer.cancel()
                if let sourceIndexPath = sourceIndexPath {
                    cleanUp(at: sourceIndexPath)
                }
                return
            }
            snapshotView.center.y = location.y
            if indexPath != sourceIndexPath {
                tableView.moveRow(at: sourceIndexPath!, to: indexPath)
                secondTaskID = tasksManager.activeTasks[indexPath.row].id
                sourceIndexPath = indexPath
            }
            
        case .ended:
            if let firstID = firstTaskID,
               let secondID = secondTaskID,
               firstID != secondTaskID {
                swapDelegate?.swapTasks(firstID: firstID, secondID: secondID)
            }
            cleanUp(at: indexPath)
            
        default:
            if let sourceIndexPath = sourceIndexPath {
                cleanUp(at: sourceIndexPath)
            }
            tableView.reloadData()
        }
    }
    
    func cleanUp(at indexPath: IndexPath) {
        guard indexPath.section != 1 else { return }
        snapshotView.transform = CGAffineTransform.identity
        let cell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
        cell.taskView.isHidden = false
        cell.placeholderView.isHidden = true
        snapshotView.frame = CGRect.zero
    }
}

extension TaskListView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasksManager.completedTasks.isEmpty ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return tasksManager.activeTasks.count
        }
        else {
            return tasksManager.completedTasks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell
        var task: TaskViewModel
        if indexPath.section == 0 {
            task = tasksManager.activeTasks[indexPath.row]
        }
        else {
            task = tasksManager.completedTasks[indexPath.row]
        }
        cell.taskView.buttonPressed = { [unowned self] in
            self.setCompletedOrCancel?(task.id)
        }
        cell.taskView.update(title: task.title, isDone: task.isDone, color: task.color)
        cell.showsReorderControl = false
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if !tasksManager.activeTasks.isEmpty {
                return Strings.active
            }
            else {
                return "No active tasks " + Strings.glasses
            }
        }
        else {
            return Strings.completed
        }
        
    }
}

extension TaskListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: Strings.delete) { [unowned self] (_, indexPath) in
            var task: TaskViewModel
            if indexPath.section == 0 {
                task = tasksManager.activeTasks[indexPath.row]
            }
            else {
                task = tasksManager.completedTasks[indexPath.row]
            }
            deleteTask?(task.id)
        }
        deleteAction.backgroundColor = UIColor.TagColors.red
        return [deleteAction]
    }
}

extension UIGestureRecognizer {
    func cancel() {
        isEnabled = false
        isEnabled = true
    }
}

protocol SwapDelegate {
    func swapTasks(firstID: Int, secondID: Int)
}
