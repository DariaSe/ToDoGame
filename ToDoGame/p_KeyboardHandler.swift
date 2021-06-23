//
//  p_KeyboardHandler.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 19.05.2021.
//

import UIKit

protocol KeyboardHandler where Self: UIViewController {
    
    func registerForKeyboardNotifications(for scrollView: UIScrollView)
}

extension KeyboardHandler {
    
    func registerForKeyboardNotifications(for scrollView: UIScrollView) {
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { notification in
            self.keyboardWasShown(for: scrollView, notification)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { _ in
            self.keyboardWillBeHidden(for: scrollView)
        }
    }
    
    func keyboardWasShown(for scrollView: UIScrollView, _ notification: Notification) {
        let info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize!.height, right: 0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }
    
    func keyboardWillBeHidden(for scrollView: UIScrollView) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        view.endEditing(true)
    }
}


