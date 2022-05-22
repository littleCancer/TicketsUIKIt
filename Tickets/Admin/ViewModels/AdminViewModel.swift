//
//  AdminViewModel.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 21.5.22..
//

import SwiftUI
import CoreData

@MainActor
class AdminViewModel : ObservableObject {
    
    let context:NSManagedObjectContext
    
    @Published var selectedTab = SelectedAdminTab.NonDiscount
    @Published var eventDiscountPairs: [EventDiscountPair] = []
    @Published var scrollViewID = UUID()
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: Notification.Name("EntityChanged"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func fetchData() {
        
        let events = getEvents()
        let discounts = getDiscounts()
        
        
        self.eventDiscountPairs = events.map {
            EventDiscountPair(event: $0, discount: findDicsountEntity(for: $0.id, discounts: discounts))
        }
        self.scrollViewID = UUID()

    }
    
    private func getDiscounts() -> [DiscountEntity] {
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
    
    private func getEvents() -> [EventEntity] {
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
    
    private func findDicsountEntity(for id: Int64, discounts: [DiscountEntity]) -> DiscountEntity? {
        return discounts.first { discount in
            discount.id == id
        }
    }
    
    private func removeFromPair(event: EventEntity) {
        if let index = self.eventDiscountPairs.firstIndex(where: {
            $0.event.id == event.id
        }) {
            eventDiscountPairs.remove(at: index)
        }
    }
    
    
    func deleteEntity(pair: EventDiscountPair) {
        
        if (selectedTab == .NonDiscount) {
            self.context.delete(pair.event)
            if let discount = pair.discount {
                self.context.delete(discount)
            }
            removeFromPair(event: pair.event)
        } else if let discount = pair.discount {
            self.context.delete(discount)
            pair.discount = nil
            self.eventDiscountPairs = eventDiscountPairs
        }
        
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
//        self.fetchData()
    }
    
    
}

enum SelectedAdminTab {
    case NonDiscount
    case Discount
}

class EventDiscountPair: Equatable {
    
    var event: EventEntity
    var discount: DiscountEntity?
    
    init(event: EventEntity, discount: DiscountEntity?) {
        self.event = event
        self.discount = discount
    }
    
    static func == (lhs: EventDiscountPair, rhs: EventDiscountPair) -> Bool {
        lhs.event.id == rhs.event.id
    }
}

