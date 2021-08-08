//
//  UserService.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 06.08.2021.
//

import Foundation

class UserService {
    
    static let shared = UserService()
    
    private init() {}
    
    var user: User = User.zero {
        didSet {
            print(user)
            NotificationCenter.default.post(Notification(name: .userChanged, object: nil, userInfo: nil))
        }
    }
    
    let userAPIService = UserAPIServiceMock()
    
    func getUser() {
        userAPIService.getUser { (user, error) in
            DispatchQueue.main.async {
                if let user = user, error == nil {
                    self.user = user
                }
                else if let error = error {
                    // handle error here
                    if let user = User.loadFromFile() {
                        self.user = user
                    }
                    else {
                        let newUser = self.user
                        User.saveToFile(user: newUser)
                    }
                }
            }
        }
    }
    
    func save(_ user: User) {
        userAPIService.save(user: user) { (success, error) in
            if success, error == nil {
                User.saveToFile(user: user)
                self.user = user
            }
            else if let error = error {
                // handle error
            }
        }
    }
}
