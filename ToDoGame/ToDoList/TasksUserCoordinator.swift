//
//  TasksUserCoordinator.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 06.08.2021.
//

import Foundation

class TasksUserCoordinator {
    
    func setCompleted() {
        var user = UserService.shared.user
        user.experience += 2
        user.water += 2
        user.gold += 3
        UserService.shared.save(user)
    }
    
    func cancel() {
        var user = UserService.shared.user
        user.experience -= 2
        user.water -= 2
        user.gold -= 3
        UserService.shared.save(user)
    }
}
