//
//  EventsMock.swift
//  Tickets
//
//  Created by Stevan Rakic on 19.5.22..
//

import Foundation

struct MockEvents {
    
    static let events = loadEvents()
    
    private static func loadEvents() -> [EventContainer]  {
        
        do {
            let result: [EventContainer] = try DataParser().parseArray(jsonFile: "Concerts.json")
            return result
        } catch {
            return []
        }
        
    }
    
}
