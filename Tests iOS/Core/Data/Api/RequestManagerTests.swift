//
//  RequestManagerTests.swift
//  Tests iOS
//
//  Created by Stevan Rakic on 22.5.22..
//

import Foundation

@testable import Tickets
import XCTest
import SDWebImageSwiftUI


class RequestManagerTests: XCTestCase {
    
    private var requestManager: RequestManagerProtocol?
    
    override func setUp() {
        super.setUp()
        guard let userDefaults = UserDefaults(suiteName: #file) else { return }
        userDefaults.removePersistentDomain(forName: #file)
        
        requestManager = RequestManager(apiManager: ApiManagerMock())
    }
    
    func testRequestEvents() async throws {
        
        guard let eventContainers:[EventContainer] = try await requestManager?.perform(MockEventsRequest.events) else {
            XCTFail("Didn't get data from the request manager")
            return
        }
        
        XCTAssertEqual(eventContainers.count, 27)
        
        let first:EventContainer = eventContainers.first!
        let last:EventContainer = eventContainers.last!
        
        XCTAssertEqual(first.type, .Discount)
        XCTAssertEqual(first.payload?.id, 1)
        XCTAssertEqual(first.payload?.name, "Hans Zimmer")
        XCTAssertEqual(first.payload?.place, nil)
        XCTAssertEqual(first.payload?.photo, "/images/HansZimmer.jpg")
        XCTAssertEqual(first.payload?.price, 50)
        XCTAssertEqual(first.payload?.quantity, 10)
        XCTAssertEqual(first.payload?.discount, 30)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let firstEventDate = formatter.date(from: "27.07.2022")
        XCTAssertEqual(first.payload?.date, firstEventDate)
        
        XCTAssertEqual(last.type, .Event)
        XCTAssertEqual(last.payload?.id, 18)
        XCTAssertEqual(last.payload?.name, "Rihanna")
        XCTAssertEqual(last.payload?.place, "Krakow")
        XCTAssertEqual(last.payload?.photo, "/images/Rihanna.jpg")
        XCTAssertEqual(last.payload?.price, 121)
        XCTAssertEqual(last.payload?.quantity, 152)
        
        let lastEventDate = formatter.date(from: "22.05.2022")
        XCTAssertEqual(last.payload?.date, lastEventDate)
        
    }
    
}
