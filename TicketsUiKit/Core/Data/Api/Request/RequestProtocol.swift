//
//  RequestProtocol.swift
//  Tickets
//
//  Created by Stevan Rakic on 18.5.22..
//

import Foundation
import Alamofire

protocol RequestProtocol {
    
    var path: String { get }
    var requestType: RequestType { get }
    var headers: [String: String] { get }
    var params: [String: Any] { get }
    var addAuthorizationToken: Bool { get }
    
}


// MARK: default

extension RequestProtocol {
    
    var host: String {
        APIConstants.host
    }
    
    var addAuthorizationToken: Bool {
        return false
    }
    
    var params: [String: Any] {
        [:]
    }

    var headers: [String: String] {
        [:]
    }
    
    func createDataTask(authToken: String = "") throws -> DataTask<String> {
        
        let httpMethod: HTTPMethod = requestType == RequestType.GET ? .get : .post
        
        var headersDict = headers
        if addAuthorizationToken {
            headersDict["Authorization"] = authToken
        }
        
        let headers: HTTPHeaders = HTTPHeaders.init(headersDict)
        
        let url = "https://" + host + path
        
        let dataRequest = AF.request(url,
                                     method: httpMethod,
                                     parameters: params,
                                     headers: headers
                                    )
        
        return dataRequest.serializingString()
        
    }
    
}
