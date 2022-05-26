//
//  HomeViewModelTests.swift
//  Tests iOS
//
//  Created by Stevan Rakic on 22.5.22..
//

import XCTest
@testable import TicketsUiKit
import Foundation


@MainActor

final class HomeViewModelTestCase: XCTestCase {
    
    var viewModel: HomeViewModel!
    
    @MainActor
      override func setUp() {
        super.setUp()
          
      }
    
    func testFetchEventsLoadingState() async {
      
          let testContext = PersistenceControllerTest.emptyTest.container.viewContext
          var viewModel: HomeViewModel = HomeViewModel(isLoading: true, eventsFetcher: TestEventsFetcherMock(), eventsStore: EventsStoreService(context: testContext))
            
          XCTAssertTrue(viewModel.isLoading, "The view model should be loading, but it isn't")
          await viewModel.fetchEvents()
          XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading, but it is")
    }
    
    func testFetchEventsDoFetchEvents() async {
        
        let testContext = PersistenceControllerTest.emptyTest.container.viewContext
        var viewModel: HomeViewModel = HomeViewModel(isLoading: true, eventsFetcher: TestEventsFetcherMock(), eventsStore: EventsStoreService(context: testContext))
        
        XCTAssertEqual(viewModel.discounts.count, 0)
        XCTAssertEqual(viewModel.upcoming.count, 0)
        XCTAssertEqual(viewModel.upcoming.count, 0)
        await viewModel.fetchEvents()
        viewModel.loadModel()
        XCTAssertEqual(viewModel.discounts.count, 8)
        XCTAssertEqual(viewModel.upcoming.count, 8)
        XCTAssertEqual(viewModel.expired.count, 4)
    }
    
}
