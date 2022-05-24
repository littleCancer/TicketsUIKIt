//
//  FetchEventsService.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 19.5.22..
//

import Foundation

struct FetchEventsService {
    
    private let requestManager: RequestManagerProtocol
    
    init (requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
}

extension FetchEventsService: EventsFetcher {
 
    func fetchEvents() async -> [EventContainer] {
        
        let request = EventsRequest.events
        
        do {
            let eventContainers:[EventContainer] = try await requestManager.perform(request)
            return eventContainers
        }
        catch {
            print("\(error.localizedDescription)")
            return []
        }
    }
    
}
