//
//  DayEntity+CoreDataProperties.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//
//

public import Foundation
public import CoreData


public typealias DayEntityCoreDataPropertiesSet = NSSet

extension DayEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayEntity> {
        return NSFetchRequest<DayEntity>(entityName: "DayEntity")
    }

    @NSManaged public var date: String
    @NSManaged public var syncDate: String
    @NSManaged public var data: Set<DayDataEntity>

}

// MARK: Generated accessors for data
extension DayEntity {

    @objc(addDataObject:)
    @NSManaged public func addToData(_ value: DayDataEntity)

    @objc(removeDataObject:)
    @NSManaged public func removeFromData(_ value: DayDataEntity)

    @objc(addData:)
    @NSManaged public func addToData(_ values: NSSet)

    @objc(removeData:)
    @NSManaged public func removeFromData(_ values: NSSet)

}

extension DayEntity : Identifiable {}

extension DayEntity {
    
    @discardableResult
    func configure(
        with proxy: Day,
        for day: Int,
        with month: Int
    ) -> DayEntity? {
        guard let context = self.managedObjectContext else {
            return nil
        }
        
        self.date = proxy.date
        self.syncDate = day.description + "-" + month.description
        
        let data = proxy.data.compactMap { event in
            
            let obj = DayDataEntity(context: context)
            obj.day = self
            obj.identifier = event.key
            obj.events = Set(event.value.compactMap { item in
                let evEt = EventEntity(context: context)
                evEt.id = item.id
                evEt.dayDataEntity = obj
                evEt.text = item.text
                evEt.year = item.year
                
                let evLinks = item.links.compactMap {
                    let link = EventLinkEntity(context: context)
                    link.id = $0.id
                    link.event = evEt
                    link.title = $0.title
                    link.url = $0.url
                    return link
                }
                evEt.links = Set(evLinks)
                
                return evEt
            })
            
            return obj
        }
        
        self.data = Set(data)
        return self
    }
}
