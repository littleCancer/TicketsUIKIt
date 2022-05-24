//
//  EventsRequest.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 18.5.22..
//

import Foundation
import SwiftUI


enum EventsRequest: RequestProtocol {
    
    case events
    
    var requestType: RequestType {
        .GET
    }
    
    var path: String {
        "/content/concert-tickets/concerts.json"
    }
    
}
