//
//  CDStorageService.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//

import CoreData
import OTDStorage
import Foundation

final class CDStorageService: StorageService {
    private lazy var persistanceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DB")
        
        if let storeDescription = container.persistentStoreDescriptions.first {
            storeDescription.shouldAddStoreAsynchronously = true
            
            #if DEBUG
            storeDescription.url = URL(fileURLWithPath: "/dev/null")
            storeDescription.shouldAddStoreAsynchronously = false
            #endif
            
            container.persistentStoreDescriptions = [storeDescription]
        }
        container.loadPersistentStores { storeDescription, error in
            if let error {
                fatalError(error.localizedDescription)
            }
            
            debugPrint(storeDescription.description)
        }
        
        return container
    }()
    
    private var context: NSManagedObjectContext {
        persistanceContainer.viewContext
    }
    
    @discardableResult
    func store<T: Storable>(_ type: T.Type) -> T {
        return T(context: self.context)
    }
    
    func fetch<T>(_ type: T.Type) -> [T] where T : Storable {
        let fetchRequest = NSFetchRequest<T>(entityName: "\(type)")
        do {
            let items = try context.fetch(fetchRequest)
            return items
        } catch {
            debugPrint(error.localizedDescription)
            return []
        }
    }
    
    func deleteAll<T>(_ type: T.Type) -> [T] where T : Storable {
        let objects = fetch(type)
        objects.forEach {
            context.delete($0)
        }
        
        save()
        
        return objects
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
