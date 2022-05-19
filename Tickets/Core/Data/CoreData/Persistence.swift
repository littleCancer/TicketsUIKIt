//
//  Persistence.swift
//  Shared
//
//  Created by Stevan Rakic on 18.5.22..
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let events:[EventContainer] = MockEvents.events
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
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Tickets")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
