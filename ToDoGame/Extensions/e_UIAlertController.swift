//
//  e_UIAlertController.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 25.05.2021.
//

import UIKit

extension UIAlertController {
    
    static func simpleAlert(title: String?, message: String?, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alert.addAction(okAction)
        return alert
    }
    
    static func deletionAlert(title: String?, message: String?, deletionHandler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: Strings.delete, style: .destructive, handler: deletionHandler)
        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        return alert
    }
}
