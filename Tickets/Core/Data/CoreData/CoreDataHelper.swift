//
//  CoreDataHelper.swift
//  Tickets
//
//  Created by Stevan Rakic on 19.5.22..
//

import CoreData

enum CoreDataHelper {
    
    static let context = PersistenceController.shared.container.viewContext
    static let previewContext = PersistenceController.preview.container.viewContext
    
    private static func clearDatabase() {
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


// MARK: - Preview Content

extension CoreDataHelper {
    
    static func getTestDiscountEntity() -> DiscountEntity? {
        let fetchRequest = DiscountEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        guard let results = try? previewContext.fetch(fetchRequest),
              let first = results.first else { return nil }
        
        return first
    }
    
    static func getTestDiscountEntities() -> [DiscountEntity]? {
        let fetchRequest = DiscountEntity.fetchRequest()
        guard let results = try? previewContext.fetch(fetchRequest),
              !results.isEmpty else { return nil }
        return results
    }
    
    static func getTestEventEntity() -> EventEntity? {
        let fetchRequest = EventEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        guard let results = try? previewContext.fetch(fetchRequest),
              let first = results.first else { return nil }
        
        return first
    }
    
    static func getTestEventEntities() -> [EventEntity]? {
        let fetchRequest = EventEntity.fetchRequest()
        guard let results = try? previewContext.fetch(fetchRequest),
              !results.isEmpty else { return nil }
        return results
    }
    
}
