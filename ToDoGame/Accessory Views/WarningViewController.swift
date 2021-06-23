//
//  WarningViewController.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 21.06.2021.
//

import UIKit

class WarningViewController: UIViewController {

    let warningContainerView = UIView()
    let warningLabel = UILabel()
    
    convenience init(message: String) {
        self.init()
        warningLabel.text = message
    }
    var message: String = "" {
        didSet {
            warningLabel.text = self.message
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        warningContainerView.center(in: view)
        warningContainerView.setWidth(equalTo: view, multiplier: 0.9)
        warningContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        warningContainerView.backgroundColor = UIColor.backgroundColor
        warningContainerView.layer.cornerRadius = 15
        warningContainerView.layer.shadowRadius = 6

        warningContainerView.alpha = 0.0
        
        warningContainerView.pinToLayoutMargins(subview: warningLabel)
        warningLabel.textAlignment = .center
        warningLabel.numberOfLines = 0

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.3, animations: {
            self.warningContainerView.alpha = 1.0
        }) { (_) in
            UIView.animate(withDuration: 0.3, delay: 3.0, options: [], animations: {
                self.warningContainerView.alpha = 0.0
            }) { (_) in
                self.remove()
            }
        }
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        UIView.animate(withDuration: 0.3, animations: {
            self.warningContainerView.alpha = 1.0
        }) { (_) in
            UIView.animate(withDuration: 0.3, delay: 3.0, options: [], animations: {
                self.warningContainerView.alpha = 0.0
            }) { (_) in
                self.remove()
            }
        }
    }
    
    
}
