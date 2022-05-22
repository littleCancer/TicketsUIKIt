//
//  CoreDataTests2.swift
//  Tests iOS
//
//  Created by Stevan Rakic on 22.5.22..
//

import XCTest

class CoreDataTests2: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testToManagedObject() throws {
        
        let previewContext = PersistenceController.preview.container.viewContext
        let fetchRequest = EventEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \EventEntity.name, ascending: true)]
        
        guard let results = try? previewContext.fetch(fetchRequest),
              let first = results.first else { return }
        
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
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
