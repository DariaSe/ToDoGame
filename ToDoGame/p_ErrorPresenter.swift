//
//  p_ErrorPresenter.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 04.08.2021.
//

import UIKit

protocol ErrorPresenter where Self: UIViewController {
    var errorView: WarningView { get set }
    func setupErrorView()
    func showError(_ error: String)
}

extension ErrorPresenter {
    func setupErrorView() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(errorView)
        errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        let width = UIScreen.main.bounds.width - 100
        errorView.setDimensions(width: width, height: 200)
    }
    
    func showError(_ error: String) {
        errorView.show(message: error)
    }
}
