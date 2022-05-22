//
//  TestEventFetcherMock.swift
//  Tests iOS
//
//  Created by Stevan Rakic on 22.5.22..
//

import Foundation


struct TestEventsFetcherMock: EventsFetcher {
    
    func fetchEventsSync() -> [EventContainer] {
        let bundle = BundleFinder().bundle
        guard let path = bundle.url(forResource: "Concerts", withExtension: "json") else {
            return []
        }
        
        var events:[EventContainer] = []
        do {
            let jsonString = try String(contentsOfFile: path.path)
            let parser = DataParser()
            events = try parser.parseArray(jsonString: jsonString)
        } catch {
            
        }
        
        return events
    }
    
    func fetchEvents() async -> [EventContainer] {
        let bundle = BundleFinder().bundle
        guard let path = bundle.url(forResource: "Concerts", withExtension: "json") else {
            return []
        }
        
        var events:[EventContainer] = []
        do {
            let jsonString = try String(contentsOfFile: path.path)
            let parser = DataParser()
            events = try parser.parseArray(jsonString: jsonString)
        } catch {
            
        }
        
        return events
    }
    
}
