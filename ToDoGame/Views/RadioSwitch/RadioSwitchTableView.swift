//
//  RadioSwitchTableView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 16.06.2021.
//

import UIKit

class RadioSwitchTableView: UIView {
    
    var options: [UIView] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var selectedOption: Int = 0 {
        didSet {
            tableView.reloadData()
        }
    }
    
    let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup() {
        self.pinToEdges(subview: tableView)
        tableView.register(RadioSwitchTableViewCell.self, forCellReuseIdentifier: RadioSwitchTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
}

extension RadioSwitchTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RadioSwitchTableViewCell()
        let option = options[indexPath.row]
        let isSelected = (selectedOption == indexPath.row)
        cell.update(with: option, isSelected: isSelected)
        cell.didSelectOption = { [unowned self] in
            selectedOption = indexPath.row
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension RadioSwitchTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
