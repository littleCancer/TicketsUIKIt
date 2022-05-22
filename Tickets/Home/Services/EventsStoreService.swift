//
//  EventsStoreService.swift
//  Tickets
//
//  Created by Stevan Rakic on 19.5.22..
//

import Foundation
import CoreData
import SwiftUI


struct EventsStoreService {
    
    private let context: NSManagedObjectContext
    
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
}

extension EventsStoreService: EventsStore {
    
    func convertAndSave(events: [EventContainer]) async throws {
                
        for eventContainer in events {
            if let payload = eventContainer.payload {
                switch eventContainer.type {
                    case .Event:
                        let event = EventEntity.init(context: context)
                        event.setValues(valueObject: payload)
                    case .Discount:
                        let discount = DiscountEntity.init(context: context)
                        discount.setValues(valueObject: payload)
                    default: break
                }

            }
            
        }
        try context.save()
        
    }
    
    func loadEvents() -> [EventEntity] {
        let eventsRequest: NSFetchRequest<EventEntity>
        eventsRequest = EventEntity.fetchRequest()
        
        eventsRequest.predicate = NSPredicate(
            format: "date > %@", argumentArray: [NSDate.now]
        )
        
        eventsRequest.sortDescriptors = [NSSortDescriptor(keyPath: \EventEntity.date, ascending: true)]
        
        guard let results = try? context.fetch(eventsRequest),
           !results.isEmpty else { return [] }
        return results
    }
    
    func loadDiscounts() -> [DiscountEntity] {
        let discountsRequest: NSFetchRequest<DiscountEntity>
        discountsRequest = DiscountEntity.fetchRequest()
        
        discountsRequest.predicate = NSPredicate(
            format: "date > %@", argumentArray: [NSDate.now]
        )
        
        discountsRequest.sortDescriptors = [NSSortDescriptor(keyPath: \DiscountEntity.date, ascending: true)]
        
        guard let results = try? context.fetch(discountsRequest),
           !results.isEmpty else { return [] }
        return results
    }
    
    func loadExpired() -> [DiscountEntity] {
        let discountsRequest: NSFetchRequest<DiscountEntity>
        discountsRequest = DiscountEntity.fetchRequest()
        
        discountsRequest.predicate = NSPredicate(
            format: "date < %@", argumentArray: [NSDate.now]
        )
        
        discountsRequest.sortDescriptors = [NSSortDescriptor(keyPath: \DiscountEntity.date, ascending: false)]
        
        guard let results = try? context.fetch(discountsRequest),
           !results.isEmpty else { return [] }
        return results
    }
    
}
