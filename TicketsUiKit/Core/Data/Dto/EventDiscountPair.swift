//
//  EventDiscountPair.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 23.5.22..
//

import Foundation

class EventDiscountPair: Equatable {
    
    var event: EventEntity
    var discount: DiscountEntity?
    
    init(event: EventEntity, discount: DiscountEntity?) {
        self.event = event
        self.discount = discount
    }
    
    static func == (lhs: EventDiscountPair, rhs: EventDiscountPair) -> Bool {
        lhs.event.id == rhs.event.id
    }
}
