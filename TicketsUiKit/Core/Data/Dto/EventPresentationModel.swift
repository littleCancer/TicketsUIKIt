//
//  EventPresentationModel.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 24.5.22..
//

import Foundation



struct EventPresentationModel {

    var id: Int16
    var name: String
    var location: String
    var imageUrl: String
    var description: String
    var price: Float
    var quantity: Int16?
    var discount: Int16?
    var discountQuantity: Int16?
    var date: Date
 
    
    static func initWithEventEntity(event: EventEntity) -> EventPresentationModel {
        
        let id = event.eventId
        let name = event.name ?? ""
        let imageUrl = ApiUtils.getImageUrl(imagePath: event.photo ?? "/images/Concert.jpg")
        let location = event.place ?? ""
        let description = event.eventDescription ?? ""
        let price = event.price
        let quantity = event.quantity
        let date = event.date ?? Date.now
        
        
        let result = EventPresentationModel(id: id, name: name, location: location, imageUrl: imageUrl, description: description, price: price, quantity: quantity, date: date)
        return result
    }
    
    static func initWithDiscountEntity(discount: DiscountEntity) -> EventPresentationModel {
        let id = discount.eventId
        let name = discount.name ?? ""
        let imageUrl = ApiUtils.getImageUrl(imagePath: discount.photo ?? "/images/Concert.jpg")
        let location = discount.place ?? ""
        let description = discount.eventDescription ?? ""
        let price = discount.price
        let quantity = discount.quantity
        let discountValue = discount.discount
        let date = discount.date ?? Date.now
    
        let result = EventPresentationModel(id: id, name: name, location: location, imageUrl: imageUrl, description: description, price: price, quantity: quantity, discount: discountValue, discountQuantity: quantity, date: date)
        return result
    }
    
}
