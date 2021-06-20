//
//  DropdownView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 19.05.2021.
//

import UIKit

class DropdownView: UIView {
    
    var selectedOption: Int = 1 {
        didSet {
            tableView.reloadData()
        }
    }
    
    var options: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    let tableView = UITableView()
    
    var didSelectOption: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.pinToEdges(subview: tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension DropdownView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = options[indexPath.row]
        cell.textLabel?.font = UIFont.normalTextFont
        cell.textLabel?.textColor = UIColor.textColor
        if indexPath.row == selectedOption {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        return cell
    }
}

extension DropdownView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedOption = indexPath.row
        didSelectOption?(selectedOption)
    }
}

struct DropdownOptions {
    
    static let noIntervalRecurrence = [Strings.daily, Strings.weekly, Strings.monthly, Strings.yearly]
    
    static func intervalRecurrence(interval: Int) -> [String] {
        [Strings.daysCount.localizedForCount(interval), Strings.weeksCount.localizedForCount(interval), Strings.monthsCount.localizedForCount(interval), Strings.yearsCount.localizedForCount(interval)]
    }
    
    static let notificationOptions = [Strings.oneMBefore, Strings.fiveMBefore, Strings.fifteenMBefore, Strings.thirtyMBefore, Strings.oneHBefore, Strings.twoHBefore]
}
