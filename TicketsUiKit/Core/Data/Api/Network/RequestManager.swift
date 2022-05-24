//
//  RequestManager.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 18.5.22..
//

import Foundation
import ObjectMapper


protocol RequestManagerProtocol {
    
    func perform<T: Mappable>(_ request: RequestProtocol) async throws -> T
    
    func perform<T: Mappable>(_ request: RequestProtocol) async throws -> [T]
                                                                    
}


class RequestManager: RequestManagerProtocol {
    
    let apiManager: ApiManagerProtocol
    let parser: DataParserProtocol
    
    init(apiManager: ApiManagerProtocol = ApiManager(),
         parser: DataParserProtocol = DataParser()) {
        self.apiManager = apiManager
        self.parser = parser
    }
    
    func perform<T>(_ request: RequestProtocol) async throws -> T where T: Mappable {
        
        let jsonString = try await apiManager.perform(request, authToken: "")
        let decoded: T = try parser.parse(jsonString: jsonString)
        
        return decoded
    }
    
    func perform<T>(_ request: RequestProtocol) async throws -> [T] where T: Mappable {
        let jsonString = try await apiManager.perform(request, authToken: "")
        let decoded: [T] = try parser.parseArray(jsonString: jsonString)
        
        return decoded
    }
    
}
