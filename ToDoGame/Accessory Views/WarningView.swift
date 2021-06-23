//
//  WarningView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 21.06.2021.
//

import UIKit

class WarningView: UIView {
    
    let container = UIView()
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToEdges(subview: container)
        label.center(in: container)
        container.layer.cornerRadius = 12
        container.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        label.textColor = UIColor.textColor
        label.font = UIFont.buttonFont
        self.isHidden = true
    }
    
    func show(message: String) {
        label.text = message
        UIView.transition(with: self, duration: 0.3, options: [.transitionCrossDissolve]) {
            self.isHidden = false
        } completion: { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                UIView.transition(with: self, duration: 0.3, options: [.transitionCrossDissolve]) {
                    self.isHidden = true
                }
            }
        }

    }
}
