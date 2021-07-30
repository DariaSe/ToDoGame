//
//  AppDelegate.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 17.04.2021.
//

import UIKit
import CoreData
import WatchConnectivity

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let coordinator = TaskListCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        UserDefaultsService.setDefault()
        coordinator.start()
        coordinator.getTasks()
        let vc = coordinator.taskListVC
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        if WCSession.isSupported() {
            let session = WCSession.default
                    session.delegate = self
                    session.activate()
                }
        return true
    }

    
    func applicationDidBecomeActive(_ application: UIApplication) {
        coordinator.taskListVC.date = Date()
    }
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ToDoGame")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate: WCSessionDelegate {

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("Message received: ", message)
        if message.keys.contains("Will activate") {
            let activeTasks = coordinator.taskModels.filter {!$0.isDone}.map { $0.dict }
            let completedTasks = coordinator.taskModels.filter {$0.isDone}.map { $0.dict }
            let tasks = activeTasks + completedTasks
            sendMessageToWatch(message: ["Tasks" : tasks])
        }
        
        if message.keys.contains("ID") {
            if let id = message["ID"] as? Int {
                DispatchQueue.main.async {
                    self.coordinator.setCompletedOrCancel(taskID: id)
                    let tasks = self.coordinator.taskModels.map { $0.dict }
                    self.sendMessageToWatch(message: ["Tasks" : tasks])
                }
            }
        }
    }
    
    func sendMessageToWatch(message: [String : Any]) {
        if WCSession.isSupported() {
            let session = WCSession.default
//            session.delegate = self
//            session.activate()
            if session.isReachable {
                session.sendMessage(message, replyHandler: nil, errorHandler: { error in
                    print("Error sending message",error)
                })
            }
        }
    }

    //below 3 functions are needed to be able to connect to several Watches
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}

    func sessionDidDeactivate(_ session: WCSession) {}

    func sessionDidBecomeInactive(_ session: WCSession) {}
}
