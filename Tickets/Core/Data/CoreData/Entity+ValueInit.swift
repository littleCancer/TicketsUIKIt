//
//  Entity+ValueInit.swift
//  Tickets
//
//  Created by Stevan Rakic on 19.5.22..
//

import Foundation
import CoreData

extension EventEntity {
    
    func setValues(valueObject: Payload) {
        self.setValue(valueObject.id, forKey: "eventId")
        self.setValue(valueObject.name, forKey: "name")
        self.setValue(valueObject.place, forKey: "place")
        self.setValue(valueObject.photo, forKey: "photo")
        self.setValue(valueObject.description, forKey: "eventDescription")
        self.setValue(valueObject.price, forKey: "price")
        self.setValue(valueObject.quantity, forKey: "quantity")
        self.setValue(valueObject.date, forKey: "date")
    }
}

extension DiscountEntity {
    
    func setValues(valueObject: Payload) {
        self.setValue(valueObject.id, forKey: "eventId")
        self.setValue(valueObject.name, forKey: "name")
        self.setValue(valueObject.place, forKey: "place")
        self.setValue(valueObject.photo, forKey: "photo")
        self.setValue(valueObject.description, forKey: "eventDescription")
        self.setValue(valueObject.price, forKey: "price")
        self.setValue(valueObject.quantity, forKey: "quantity")
        self.setValue(valueObject.discount, forKey: "discount")
        self.setValue(valueObject.date, forKey: "date")
        self.setValue()
    }
    
}
