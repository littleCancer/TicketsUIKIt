//
//  AdminViewModelTests.swift
//  Tests iOS
//
//  Created by Stevan Rakic on 22.5.22..
//

import XCTest
@testable import Tickets

class AdminViewModelTests: XCTestCase {

    let testContext = PersistenceControllerTest.test.container.viewContext
    var viewModel: AdminViewModel!
    
    @MainActor
    override func setUp() {
        super.setUp()
        viewModel = AdminViewModel(context: testContext)
    }


    @MainActor
    func testFetchingData() async {

        XCTAssertEqual(viewModel.eventDiscountPairs.count, 9)
        
        let first = viewModel.eventDiscountPairs[0]
        
        XCTAssertNotNil(first.discount)
        XCTAssertEqual(first.event.name, "Ed Sheeran")
        XCTAssertEqual(first.event.place, "Lisbon")
        XCTAssertEqual(first.event.price, 125)
        
        XCTAssertEqual(first.discount?.discount, 40)
        
        let third = viewModel.eventDiscountPairs[2]
        XCTAssertNil(third.discount)
        XCTAssertEqual(third.event.name, "Celine Dion")
        XCTAssertEqual(third.event.place, "Rome")
        XCTAssertEqual(third.event.price, 132)
        
        
    }
    
    
    @MainActor
    func testDeleteEventEntity() async {
        XCTAssertEqual(viewModel.eventDiscountPairs.count, 9)
        viewModel.selectedTab = .NonDiscount
        let first = viewModel.eventDiscountPairs[0]
        viewModel.deleteEntity(pair: first)
        XCTAssertEqual(viewModel.eventDiscountPairs.count, 8)
    }
    
    @MainActor
    func testDeleteDiscountEntity() async {
        XCTAssertEqual(viewModel.eventDiscountPairs.count, 9)
        viewModel.selectedTab = .Discount
        let first = viewModel.eventDiscountPairs[0]
        viewModel.deleteEntity(pair: first)
        XCTAssertEqual(viewModel.eventDiscountPairs.count, 9)
        XCTAssertNil(first.discount)
    }
    
}
