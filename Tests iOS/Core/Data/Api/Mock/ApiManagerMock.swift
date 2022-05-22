//
//  ApiManagerMock.swift
//  Tests iOS
//
//  Created by Stevan Rakic on 22.5.22..
//

import Foundation
@testable import Tickets


struct ApiManagerMock: ApiManagerProtocol {
    
    func perform(_ request: RequestProtocol, authToken: String) async throws -> String {
        let string = try String(contentsOfFile: request.path)
        return string
    }
    
    
    func perform(_ request: RequestProtocol, authToken: String) async throws -> Data {
      return try Data(contentsOf: URL(fileURLWithPath: request.path), options: .mappedIfSafe)
    }

}
