//
//  ApiManagerProtocol.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 18.5.22..
//

import Foundation


protocol ApiManagerProtocol {
    func perform(_ request: RequestProtocol, authToken: String) async throws -> String
}

class ApiManager: ApiManagerProtocol {
    
    func perform(_ request: RequestProtocol, authToken: String) async throws -> String {
        let dataRequest = try request.createDataTask()
        
        let response = await dataRequest.response
        
        guard response.error == nil else {
            throw NetworkError.invalidServerResponse
        }
        
        guard let stringResponse = response.value else {
            throw NetworkError.invalidServerResponse
        }
        
        return stringResponse
    }

}
