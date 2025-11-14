//
//  EventEntity+CoreDataProperties.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//
//

public import Foundation
public import CoreData


public typealias EventEntityCoreDataPropertiesSet = NSSet

extension EventEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventEntity> {
        return NSFetchRequest<EventEntity>(entityName: "EventEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var text: String
    @NSManaged public var year: String
    @NSManaged public var links: Set<EventLinkEntity>
    @NSManaged public var dayDataEntity: DayDataEntity

}

// MARK: Generated accessors for links
extension EventEntity {

    @objc(addLinksObject:)
    @NSManaged public func addToLinks(_ value: EventLinkEntity)

    @objc(removeLinksObject:)
    @NSManaged public func removeFromLinks(_ value: EventLinkEntity)

    @objc(addLinks:)
    @NSManaged public func addToLinks(_ values: NSSet)

    @objc(removeLinks:)
    @NSManaged public func removeFromLinks(_ values: NSSet)

}

extension EventEntity : Identifiable {

}
