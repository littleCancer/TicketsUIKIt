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
    
}
