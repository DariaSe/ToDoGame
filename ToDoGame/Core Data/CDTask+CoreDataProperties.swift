//
//  CDTask+CoreDataProperties.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 30.06.2021.
//
//

import Foundation
import CoreData


extension CDTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTask> {
        return NSFetchRequest<CDTask>(entityName: "CDTask")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: Int16
    @NSManaged public var orderID: Int16
    @NSManaged public var startDate: Date?
    @NSManaged public var executionLog: [Date]?
    @NSManaged public var notificationOption: Int16
    @NSManaged public var color: Int16
    @NSManaged public var notes: String?
    @NSManaged public var recurrenceRule: CDRecurrenceRule?

}
