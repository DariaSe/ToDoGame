//
//  Tag.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 16.05.2021.
//

import Foundation

struct Tag: Codable, Equatable {
    
    var id: Int
    var title: String
    var color: Int
    
    //MARK: Decoding and encoding
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("tags").appendingPathExtension("plist")
    
    static func saveToFile(tags: [Tag]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedTags = try? propertyListEncoder.encode(tags)
        try? encodedTags?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Tag]? {
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedTagsData = try? Data(contentsOf: archiveURL) else { return nil }
        return try? propertyListDecoder.decode(Array<Tag>.self, from: retrievedTagsData)
    }
    
    static var sample: [Tag] { [Tag(id: 1, title: "Work", color: 2), Tag(id: 2, title: "Entertainment", color: 7), Tag(id: 3, title: "Others", color: 5)]}
}
