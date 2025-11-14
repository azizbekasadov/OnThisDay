//
//  EventLinkEntity+CoreDataProperties.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//
//

public import Foundation
public import CoreData


public typealias EventLinkEntityCoreDataPropertiesSet = NSSet

extension EventLinkEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventLinkEntity> {
        return NSFetchRequest<EventLinkEntity>(entityName: "EventLinkEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var url: URL
    @NSManaged public var event: EventEntity

}

extension EventLinkEntity : Identifiable {

}
