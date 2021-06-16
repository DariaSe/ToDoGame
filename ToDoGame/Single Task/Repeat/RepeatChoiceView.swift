//
//  RepeatChoiceView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 16.06.2021.
//

import UIKit

class RepeatChoiceView: RadioSwitchTableView {
    
    let yesLabel = UILabel()
    let noLabel = UILabel()
    let maybeLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initialSetup() {
        super.initialSetup()
        yesLabel.text = "Yes"
        noLabel.text = "No"
        maybeLabel.text = "Maybe"
        options = [yesLabel, noLabel, maybeLabel]
    }
}
