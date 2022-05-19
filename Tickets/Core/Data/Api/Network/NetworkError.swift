//
//  NetworkError.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 18.5.22..
//

import Foundation

public enum NetworkError: LocalizedError {
    
    case invalidServerResponse
    case invalidURL
    
    public var errorDescription: String? {
        switch self {
        case .invalidServerResponse:
            return "The server returned an invalid response."
        case .invalidURL:
            return "URL string is malformed."
        }
    }
    
}
