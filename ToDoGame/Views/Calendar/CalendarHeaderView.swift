//
//  CalendarHeaderView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 17.06.2021.
//

import UIKit

class CalendarHeaderView: UIView {
    
    var title: String = "" {
        didSet {
            titleButton.setTitle(title, for: .normal)
        }
    }
    
    var delegate: CalendarDelegate?
    
    let leftButton = UIButton()
    let titleButton = UIButton()
    let rightButton = UIButton()
    
    let arrowLeft = UIImage(named: "Arrow left")?.withRenderingMode(.alwaysTemplate)
    let arrowRight = UIImage(named: "Arrow right")?.withRenderingMode(.alwaysTemplate)

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToLayoutMargins(subview: leftButton, trailing: nil, top: nil, bottom: nil)
        leftButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.pinToLayoutMargins(subview: rightButton, leading: nil, top: nil, bottom: nil)
        rightButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleButton.center(in: self)
        leftButton.setDimensions(width: 40, height: 40)
        rightButton.setDimensions(width: 40, height: 40)
        
        leftButton.setImage(arrowLeft, for: .normal)
        leftButton.tintColor = UIColor.textColor
        leftButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        rightButton.setImage(arrowRight, for: .normal)
        rightButton.tintColor = UIColor.textColor
        rightButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        
        titleButton.titleLabel?.font = UIFont.normalTextFont
        titleButton.titleLabel?.textAlignment = .center
        titleButton.setTitleColor(UIColor.textColor, for: .normal)
        titleButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
    }
    
    @objc func buttonPressed(sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in sender.transform = CGAffineTransform.identity }
        switch sender {
        case leftButton: delegate?.setPrevious()
        case rightButton: delegate?.setNext()
        case titleButton: delegate?.titlePressed()
        default: break
        }
    }
}

protocol CalendarDelegate {
    func setPrevious()
    func setNext()
    func titlePressed()
}
