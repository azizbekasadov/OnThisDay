//
//  EventEntity+CoreDataClass.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//
//

public import Foundation
public import CoreData
public import OTDStorage

public typealias EventEntityCoreDataClassSet = NSSet

@objc(EventEntity)
public class EventEntity: NSManagedObject {

}

extension EventEntity: Storable {}
