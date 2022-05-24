//
//  EventContainer.swift
//  Tickets
//
//  Created by Stevan Rakic on 18.5.22..
//

import Foundation
import ObjectMapper

struct EventContainer: Mappable {
    
    var type: Type?
    var payload: Payload?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        type                <- (map["type"],EnumTransform<Type>())
        payload             <- map["payload"]
    }
    
}
