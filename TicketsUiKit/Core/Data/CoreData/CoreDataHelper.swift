//
//  CoreDataHelper.swift
//  Tickets
//
//  Created by Stevan Rakic on 19.5.22..
//

import CoreData

enum CoreDataHelper {
    
    static let context = PersistenceController.shared.container.viewContext
    
    public static func clearDatabase() async {
        let entities = PersistenceController.shared.container.managedObjectModel.entities
        entities.compactMap(\.name).forEach(clearTable)
    }
    
    private static func clearTable(_ entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            fatalError("\(#file), \(#function), \(error.localizedDescription)")
        }
    }
    
}

