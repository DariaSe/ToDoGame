//
//  ReachabilityTestViewController.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 08.08.2021.
//

import UIKit

class ReachabilityTestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(statusManager),
                         name: .flagsChanged,
                         object: nil)
        updateUserInterface()
    }
    func updateUserInterface() {
        switch Network.reachability.status {
        case .unreachable:
            view.backgroundColor = .red
        case .wwan:
            view.backgroundColor = .yellow
        case .wifi:
            view.backgroundColor = .green
        }
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
    }
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }
}
