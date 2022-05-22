//
//  EventsRequestMock.swift
//  Tests iOS
//
//  Created by Stevan Rakic on 22.5.22..
//

import Foundation
@testable import Tickets
import SwiftUI

enum MockEventsRequest: RequestProtocol {
    
    case events

    var requestType: RequestType {
        .GET
    }
    
    var path: String {
        let bundle = BundleFinder().bundle
        guard let path = bundle.url(forResource: "Concerts", withExtension: "json") else {
            return ""
        }
        return path.path
    }
    
}

class BundleFinder {
    var bundle: Bundle
    
    init() {
        bundle = Bundle(for: type(of: self))
    }
}
