//
//  Persistence.swift
//  Tests iOS
//
//  Created by Stevan Rakic on 22.5.22..
//

import Foundation
import CoreData
@testable import Tickets

struct PersistenceControllerTest {
    
    let container: NSPersistentContainer
    
    static let test: PersistenceControllerTest = {
        
        let result = PersistenceControllerTest()
        let viewContext = result.container.viewContext
        
        var events = TestEventsFetcherMock().fetchEventsSync()
        
        
        for eventContainer in events {
            if let payload = eventContainer.payload {
                switch eventContainer.type {
                    case .Event:
                        let event = EventEntity.init(context: viewContext)
                        event.setValues(valueObject: payload)
                    case .Discount:
                        let discount = DiscountEntity.init(context: viewContext)
                        discount.setValues(valueObject: payload)
                    default: break
                }

            }
            
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
        
    } ()
    
    static let emptyTest: PersistenceControllerTest = {
        let result = PersistenceControllerTest()
        return result
    } ()
    
    init() {
        let model: NSManagedObjectModel = {
            let bundle = BundleFinder().bundle
            let modelURL = bundle.url(forResource: "Tickets", withExtension: "momd")!
            return NSManagedObjectModel(contentsOf: modelURL)!
        }()
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType

        container = NSPersistentContainer(
            name: "Tickets",
          managedObjectModel: model)


        container.persistentStoreDescriptions = [persistentStoreDescription]

        container.loadPersistentStores { _, error in
          if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
          }
        }
    }
}
