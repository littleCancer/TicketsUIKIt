//
//  AdminViewModelTests.swift
//  Tests iOS
//
//  Created by Stevan Rakic on 22.5.22..
//

import XCTest
@testable import TicketsUiKit

class AdminViewModelTests: XCTestCase {

    var viewModel: AdminViewModel!
    
    @MainActor
    override func setUp() {
        super.setUp()
        let testContext = PersistenceControllerTest.createNewContainerWithData().viewContext
        viewModel = AdminViewModel(context: testContext)
    }

    @MainActor
    func testFetchingData() async {

        XCTAssertEqual(viewModel.eventDiscountPairs.count, 8)
        
        let first = viewModel.eventDiscountPairs[0]
        
        XCTAssertNotNil(first.discount)
        XCTAssertEqual(first.event.name, "Hans Zimmer")
        XCTAssertEqual(first.event.place, nil)
        XCTAssertEqual(first.event.price, 50)
        
        XCTAssertEqual(first.discount?.discount, 30)
        
        let second = viewModel.eventDiscountPairs[1]
        XCTAssertNil(second.discount)
        XCTAssertEqual(second.event.name, "Celine Dion")
        XCTAssertEqual(second.event.place, "Rome")
        XCTAssertEqual(second.event.price, 132)
        
        
    }
    
    @MainActor
    func testDeleteEventEntity() async {
        XCTAssertEqual(viewModel.eventDiscountPairs.count, 8)
        viewModel.selectedTab = .NonDiscount
        let first = viewModel.eventDiscountPairs[0]
        viewModel.deleteEntity(pair: first)
        XCTAssertEqual(viewModel.eventDiscountPairs.count, 7)
    }
    
    @MainActor
    func testDeleteDiscountEntity() async {
        XCTAssertEqual(viewModel.eventDiscountPairs.count, 8)
        viewModel.selectedTab = .Discount
        let first = viewModel.eventDiscountPairs[0]
        viewModel.deleteEntity(pair: first)
        XCTAssertEqual(viewModel.eventDiscountPairs.count, 8)
        XCTAssertNil(first.discount)
    }
    
    
}
