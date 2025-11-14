//
//  DayDataEntity+CoreDataClass.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//
//

public import Foundation
public import CoreData
public import OTDStorage

public typealias DayDataEntityCoreDataClassSet = NSSet

@objc(DayDataEntity)
public class DayDataEntity: NSManagedObject {

}

extension DayDataEntity: Storable {}
