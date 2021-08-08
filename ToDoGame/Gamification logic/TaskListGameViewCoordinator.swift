//
//  TaskListGameViewCoordinator.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 08.08.2021.
//

import Foundation

class TaskListGameViewCoordinator {
    
    func didSetCompleted() {
        var user = UserService.shared.user
        user.experience += 2
        user.water += 2
        user.gold += 3
        UserService.shared.save(user)
    }
    
    func didCancel() {
        var user = UserService.shared.user
        user.experience -= 2
        user.water -= 2
        user.gold -= 3
        UserService.shared.save(user)
    }
}
