//
//  CoreDataTests.swift
//  Tests iOS
//
//  Created by Stevan Rakic on 22.5.22..
//

import XCTest
@testable import TicketsUiKit
import CoreData

class CoreDataTests: XCTestCase {
    
    override func setUpWithError() throws {
      try super.setUpWithError()
    }

    override func tearDownWithError() throws {
      try super.tearDownWithError()
    }
    
    func testToManagedObject() throws {
        
        let previewContext = PersistenceControllerTest.test.container.viewContext
        let fetchRequest = EventEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \EventEntity.name, ascending: true)]
        
        guard let results = try? previewContext.fetch(fetchRequest),
              let first = results.first else
        {
            return
            
        }
        
        XCTAssert(first.name == "Andrea Bocelli", """
        Event name did not match, was expecting Andrea Bocelli, got
        \(String(describing: first.name))
        """)
        
        XCTAssert(first.place == "Milano", """
          Event place did not match, was expecting Milano, got
          \(String(describing: first.place))
        """)
        
        XCTAssert(first.quantity == 132, """
        Event price did not match, was expecting Short, got
        \(first.quantity)
      """)
        
    }
    
    func testDeleteManagedObject() throws {
      let previewContext =
        PersistenceControllerTest.test.container.viewContext

      let fetchRequest = EventEntity.fetchRequest()
      guard let results = try? previewContext.fetch(fetchRequest),
        let first = results.first else { return }

      let expectedResult = results.count - 1
      previewContext.delete(first)

      guard let resultsAfterDeletion = try? previewContext.fetch(fetchRequest)
        else { return }

      XCTAssertEqual(expectedResult, resultsAfterDeletion.count, """
        The number of results was expected to be \(expectedResult) after deletion, was \(results.count)
      """)
    }
    
}
