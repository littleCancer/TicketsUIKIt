//
//  HomeViewModel.swift
//  Tickets
//
//  Created by Stevan Rakic on 19.5.22..
//

import Foundation
import SwiftUI

protocol EventsFetcher {
    func fetchEvents() async -> [EventContainer]
}

protocol EventsStore {
    func convertAndSave(events: [EventContainer]) async throws
}

@MainActor
final class HomeViewModel: ObservableObject {
    
    @AppStorage("hasDataStored") var hasDataInStorage = false
    @Published var isLoading: Bool
    
    private let eventsFetcher: EventsFetcher
    private let eventsStore: EventsStore
    
    init(
        isLoading: Bool = true,
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
}
