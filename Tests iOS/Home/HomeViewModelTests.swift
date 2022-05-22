//
//  HomeViewModelTests.swift
//  Tests iOS
//
//  Created by Stevan Rakic on 22.5.22..
//

import XCTest
@testable import Tickets
import Foundation


@MainActor

final class HomeViewModelTestCase: XCTestCase {
    
    let testContext = PersistenceControllerTest.emptyTest.container.viewContext
    var viewModel: HomeViewModel!
    
    @MainActor
      override func setUp() {
        super.setUp()
          
        viewModel = HomeViewModel(isLoading: true, eventsFetcher: TestEventsFetcherMock(), eventsStore: EventsStoreService(context: testContext))
      }
    
    func testFetchEventsLoadingState() async {
      XCTAssertTrue(viewModel.isLoading, "The view model should be loading, but it isn't")
      await viewModel.fetchEvents()
      XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading, but it is")
    }
    
    func testFetchEventsDoFetchEvents() async {
        XCTAssertEqual(viewModel.discounts.count, 0)
        XCTAssertEqual(viewModel.upcoming.count, 0)
        XCTAssertEqual(viewModel.upcoming.count, 0)
        await viewModel.fetchEvents()
        viewModel.loadModel()
        XCTAssertEqual(viewModel.discounts.count, 9)
        XCTAssertEqual(viewModel.upcoming.count, 9)
        XCTAssertEqual(viewModel.expired.count, 3)
    }
    
}
