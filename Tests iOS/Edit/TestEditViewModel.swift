//
//  TestEditViewModel.swift
//  Tests iOS
//
//  Created by Stevan Rakic on 22.5.22..
//

import XCTest
@testable import Tickets
import CoreData

class TestEditViewModel: XCTestCase {

    var testContext : NSManagedObjectContext?
    
    @MainActor
    override func setUp() {
        super.setUp()
        testContext = PersistenceControllerTest.createNewContainerWithData().viewContext
    }

    func getTestDiscountEntity(id: Int64) -> DiscountEntity? {
        let fetchRequest = DiscountEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id == %@", argumentArray: [id]
        )
        fetchRequest.fetchLimit = 1
        guard let results = try? testContext!.fetch(fetchRequest),
              let first = results.first else { return nil }
        
        return first
    }
     
    func getTestEventEntity(id: Int64) -> EventEntity? {
        let fetchRequest = EventEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id == %@", argumentArray: [id]
        )
        fetchRequest.fetchLimit = 1
        guard let results = try? testContext!.fetch(fetchRequest),
              let first = results.first else { return nil }
        
        return first
    }
    
    func getTestEventEntities() -> [EventEntity]? {
        let fetchRequest = EventEntity.fetchRequest()
        guard let results = try? testContext!.fetch(fetchRequest),
              !results.isEmpty else { return nil }
        return results
    }
    
    func getTestDiscountEntities() -> [DiscountEntity]? {
        let fetchRequest = DiscountEntity.fetchRequest()
        guard let results = try? testContext!.fetch(fetchRequest),
              !results.isEmpty else { return nil }
        return results
    }
    
    @MainActor
    func testUpdateEvent() async {
        let event = getTestEventEntity(id: 4)
        let discount = getTestDiscountEntity(id: 4)
        let pair = EventDiscountPair(event: event!, discount: discount!)
        
        let viewModel = EditEventViewModel(context: testContext!, eventDiscountPair: pair)
        viewModel.price = "500"
        viewModel.updateEntity(pair: pair)
        
        let updatedEntiry = getTestEventEntity(id: 4)
        XCTAssertEqual(updatedEntiry?.price, NSDecimalNumber(string: "500"))
    }
    
    @MainActor
    func testCreateEvent() async {
        
        let eventsCount = getTestEventEntities()?.count
        let discountsCount = getTestDiscountEntities()?.count
        
        
        let viewModel = EditEventViewModel(context: testContext!, eventDiscountPair: nil)
        viewModel.discountOn = true
        viewModel.name = "Tiesto"
        viewModel.price = "500"
        viewModel.discount = "40"
        viewModel.discountQuantity = "20"
        viewModel.place = "Amsterdam"
        viewModel.quantity = "100"
        viewModel.date = Date.now
        viewModel.eventDescription = "Party all the night"
        
        viewModel.createEntity()

        XCTAssertEqual(getTestEventEntities()?.count, eventsCount! + 1)
        XCTAssertEqual(getTestDiscountEntities()?.count, discountsCount! + 1)
    }


}
