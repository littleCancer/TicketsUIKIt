//
//  EventsFetcherMock.swift
//  Tickets
//
//  Created by Stevan Rakic on 19.5.22..
//

import Foundation

struct EventsFetcherMock: EventsFetcher {
    
    
    func fetchEvents() async -> [EventContainer] {
        MockEvents.events
    }
    
    
}
