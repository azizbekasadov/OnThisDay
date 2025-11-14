//
//  EventLinkEntity+CoreDataClass.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//
//

public import Foundation
public import CoreData
public import OTDStorage

public typealias EventLinkEntityCoreDataClassSet = NSSet

@objc(EventLinkEntity)
public class EventLinkEntity: NSManagedObject {}

extension EventLinkEntity: Storable {}
