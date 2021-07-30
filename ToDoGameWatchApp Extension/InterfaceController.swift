//
//  InterfaceController.swift
//  ToDoGameWatchApp Extension
//
//  Created by Дарья Селезнёва on 12.07.2021.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {
    
    var tasks: [TaskViewModel] = [] {
        didSet {
            setupRows()
        }
    }
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setupRows()
    }
    
    func setupRows() {
        table.setNumberOfRows(tasks.count, withRowType: "taskRowController")
        
        for index in 0..<table.numberOfRows {
            guard let controller = table.rowController(at: index) as? TableRowController else { continue }
            
            controller.task = tasks[index]
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        print("Apple Watch app will activate")
        // ask for data here
        sendMessageToPhone(message: ["Will activate" : 0])
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let task = tasks[rowIndex]
//        task.isDone = !task.isDone
//        tasks.replace(task, with: task)
        sendMessageToPhone(message: ["ID" : task.id])
    }
    
    func sendMessageToPhone(message: [String : Any]) {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            if session.isReachable {
                session.sendMessage(message, replyHandler: nil, errorHandler: { error in
                    print("Error sending message",error)
                })
            }
        }
    }
}

extension InterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if message.keys.contains("Tasks") {
            if let tasksDict = message["Tasks"] as? [[String : Any]] {
                DispatchQueue.main.async {
                    let tasks = tasksDict.compactMap {TaskViewModel.recreatedFromDict($0)}
                    self.tasks = tasks
                }
            }
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
}
