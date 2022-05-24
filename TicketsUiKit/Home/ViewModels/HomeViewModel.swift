//
//  HomeViewModel.swift
//  Tickets
//
//  Created by Stevan Rakic on 19.5.22..
//

import Foundation
import SwiftUI
import CoreData

protocol EventsFetcher {
    func fetchEvents() async -> [EventContainer]
}

protocol EventsStore {
    func convertAndSave(events: [EventContainer]) async throws
    func loadEvents() -> [EventEntity]
    func loadDiscounts() -> [DiscountEntity]
    func loadExpired() -> [DiscountEntity]
}

@MainActor
final class HomeViewModel: ObservableObject {
    
    @AppStorage("hasDataStored") var hasDataInStorage = false
    @Published var isLoading: Bool
    
    private let eventsFetcher: EventsFetcher
    private let eventsStore: EventsStore
    
    @Published var upcoming: [EventEntity] = []
    @Published var discounts: [DiscountEntity] = []
    @Published var expired: [DiscountEntity] = []
    
    init(
        isLoading: Bool = false,
        eventsFetcher: EventsFetcher,
        eventsStore: EventsStore
    ) {
        self.isLoading = isLoading
        self.eventsFetcher = eventsFetcher
        self.eventsStore = eventsStore
    }
    
    func fetchEvents() async {
        isLoading = true
        let eventContainers = await eventsFetcher.fetchEvents()
        do {
            try await eventsStore.convertAndSave(events: eventContainers)
            hasDataInStorage = true
        } catch {
            print("Error storing events... \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    func loadModel() {
        self.upcoming = eventsStore.loadEvents()
        self.discounts = eventsStore.loadDiscounts()
        self.expired = eventsStore.loadExpired()
    }
}
