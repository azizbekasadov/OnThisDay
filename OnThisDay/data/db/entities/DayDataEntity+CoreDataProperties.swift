//
//  DayDataEntity+CoreDataProperties.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//
//

public import Foundation
public import CoreData


public typealias DayDataEntityCoreDataPropertiesSet = NSSet

extension DayDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayDataEntity> {
        return NSFetchRequest<DayDataEntity>(entityName: "DayDataEntity")
    }

    @NSManaged public var identifier: String
    @NSManaged public var events: Set<EventEntity>
    @NSManaged public var day: DayEntity
}

// MARK: Generated accessors for events
extension DayDataEntity {

    @objc(addEventsObject:)
    @NSManaged public func addToEvents(_ value: EventEntity)

    @objc(removeEventsObject:)
    @NSManaged public func removeFromEvents(_ value: EventEntity)

    @objc(addEvents:)
    @NSManaged public func addToEvents(_ values: NSSet)

    @objc(removeEvents:)
    @NSManaged public func removeFromEvents(_ values: NSSet)

}

extension DayDataEntity : Identifiable {}
