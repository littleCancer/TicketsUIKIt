//
//  DataParser.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 18.5.22..
//

import Foundation
import ObjectMapper


protocol DataParserProtocol {
    
    func parse<T: Mappable>(jsonString: String) throws -> T
    
    func parseArray<T: Mappable>(jsonString: String) throws -> [T]
}


class DataParser: DataParserProtocol {
    
    func parse<T: Mappable>(jsonString: String) throws -> T {
        
        guard let parsed = Mapper<T>().map(JSONObject: jsonString) else {
            throw NetworkError.invalidServerResponse
        }
        return parsed
    }
    
    func parseArray<T: Mappable>(jsonString: String) throws -> [T] {
        
        guard let parsed = Mapper<T>().mapArray(JSONString: jsonString) else {
            throw NetworkError.invalidServerResponse
        }
        return parsed
        
    }
    
    func parseArray<T: Mappable>(jsonFile: String) throws -> [T] {
        
        guard let parsed = Mapper<T>().mapArray(JSONfile: jsonFile) else {
            throw NetworkError.invalidServerResponse
        }
        return parsed
        
    }
    
    
    
}
