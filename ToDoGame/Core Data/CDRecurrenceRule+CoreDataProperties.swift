//
//  CDRecurrenceRule+CoreDataProperties.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 30.06.2021.
//
//

import Foundation
import CoreData


extension CDRecurrenceRule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDRecurrenceRule> {
        return NSFetchRequest<CDRecurrenceRule>(entityName: "CDRecurrenceRule")
    }

    @NSManaged public var recurrenceFrequency: Int16
    @NSManaged public var interval: Int16
    @NSManaged public var weekdays: [Int]?

}
