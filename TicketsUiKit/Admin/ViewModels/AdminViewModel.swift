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
    
    let eventStore:EventsStoreService
    let context:NSManagedObjectContext
    
    @Published var selectedTab = SelectedAdminTab.NonDiscount
    @Published var eventDiscountPairs: [EventDiscountPair] = []
    @Published var scrollViewID = UUID()
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.eventStore = EventsStoreService(context: context)
        fetchData()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: Notification.Name("EntityChanged"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func fetchData() {
        
        let events = eventStore.loadEvents()
        let discounts = eventStore.loadDiscounts()
        
        self.eventDiscountPairs = events.map {
            return EventDiscountPair(event: $0, discount: findDicsountEntity(for: $0.id, discounts: discounts))
        }
        
        self.scrollViewID = UUID()

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
        
    }
    
}

enum SelectedAdminTab {
    case NonDiscount
    case Discount
}

