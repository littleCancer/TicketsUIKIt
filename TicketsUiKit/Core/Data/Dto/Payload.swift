//
//  Payload.swift
//  Tickets
//
//  Created by Stevan Rakic on 18.5.22..
//

import Foundation
import ObjectMapper

struct Payload : Mappable {
    
    var id: Int?
    var name: String?
    var place: String?
    var photo: String?
    var description: String?
    var price: Int?
    var quantity: Int?
    var discount: Int?
    var date: Date?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        
        id              <- map["id"]
        name            <- map["name"]
        place           <- map["place"]
        photo           <- map["photo"]
        description     <- map["description"]
        price           <- map["price"]
        quantity        <- map["quantity"]
        discount        <- map["discount"]
        date            <- (map["date"], DateFormatterTransform(dateFormatter: dateFormatter))
    }
    
}
