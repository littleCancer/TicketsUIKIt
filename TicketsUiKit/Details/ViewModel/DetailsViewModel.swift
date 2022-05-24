//
//  DetailsViewModel.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 24.5.22..
//

import Foundation

class DetailsViewModel: ObservableObject {
    
    let eventPresentationModel: EventPresentationModel
    
    
    init(eventEntity: EventEntity) {
        self.eventPresentationModel = EventPresentationModel.initWithEventEntity(event: eventEntity)
    }
    
    init(discountEntity: DiscountEntity) {
        self.eventPresentationModel = EventPresentationModel.initWithDiscountEntity(discount: discountEntity)
    }
    
}
