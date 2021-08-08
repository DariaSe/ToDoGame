//
//  Network.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 06.08.2021.
//

import Foundation

struct Network {
    static var reachability: Reachability!
    enum Status: String {
        case unreachable, wifi, wwan
    }
    enum Error: Swift.Error {
        case failedToSetCallout
        case failedToSetDispatchQueue
        case failedToCreateWith(String)
        case failedToInitializeWith(sockaddr_in)
    }
}
