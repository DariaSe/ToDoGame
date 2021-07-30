//
//  TableRowController.swift
//  ToDoGameWatchApp Extension
//
//  Created by Дарья Селезнёва on 12.07.2021.
//

import WatchKit

class TableRowController: NSObject {
    
    let roundOn = UIImage(named: "Round - on")
    let roundOff = UIImage(named: "Round - off")
    
    var task: TaskViewModel? {
        didSet {
            guard let task = task else { return }
            if let color = task.color {
                colorView.setColor(UIColor.tagColor(index: color))
            }
            else {
                colorView.setColor(UIColor.noColorColor)
            }
            label.setText(task.title)
            let image = task.isDone ? roundOn : roundOff
            checkImage.setImage(image?.withRenderingMode(.alwaysTemplate))
            checkImage.setTintColor(UIColor.white.withAlphaComponent(0.9))
        }
    }
    
    @IBOutlet weak var colorView: WKInterfaceSeparator!
    
    @IBOutlet weak var label: WKInterfaceLabel!
    
    @IBOutlet weak var checkImage: WKInterfaceImage!
    
}
