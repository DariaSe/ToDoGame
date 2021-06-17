//
//  CheckboxButton.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 16.06.2021.
//

import UIKit

class CheckboxButton: UIButton {
    
    var selectedImage: UIImage? = UIImage(named: "Square - on") {
        didSet {
            self.setImage(selectedImage?.withRenderingMode(.alwaysTemplate), for: .selected)
        }
    }
    var deselectedImage: UIImage? = UIImage(named: "Square - off") {
        didSet {
            self.setImage(deselectedImage?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.setImage(selectedImage?.withRenderingMode(.alwaysTemplate), for: .selected)
        self.setImage(deselectedImage?.withRenderingMode(.alwaysTemplate), for: .normal)
        tintColor = UIColor.buttonColor
    }
}
