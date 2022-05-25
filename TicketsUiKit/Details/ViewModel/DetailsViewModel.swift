//
//  DetailsViewModel.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 24.5.22..
//

import Foundation
import UIKit

class DetailsViewModel: ObservableObject {
    
    let eventPresentationModel: EventPresentationModel
    
    var cells:[CellType] = []
    
    init(eventEntity: EventEntity) {
        
        self.eventPresentationModel = EventPresentationModel.initWithEventEntity(event: eventEntity)
        
        var cells:[CellType] = []
        cells.append(CellType.name)
        cells.append(CellType.description)
        cells.append(CellType.place)
        cells.append(CellType.date)
        cells.append(CellType.time)
        cells.append(CellType.quantity)
        cells.append(CellType.finalPrice)
        self.cells = cells
    }
    
    init(discountEntity: DiscountEntity) {
        self.eventPresentationModel = EventPresentationModel.initWithDiscountEntity(discount: discountEntity)
        
        var cells:[CellType] = []
        cells.append(CellType.name)
        cells.append(CellType.description)
        cells.append(CellType.place)
        cells.append(CellType.date)
        cells.append(CellType.time)
        cells.append(CellType.quantity)
        cells.append(CellType.discount)
        cells.append(CellType.finalPrice)
        self.cells = cells
    }
    
}

enum CellType: CaseIterable {
    
    case name
    case description
    case place
    case date
    case time
    case quantity
    case discount
    case finalPrice
    
    func getTypeDescription() -> String {
        
        switch(self) {
            
        case .name:
            return ""
        case .description:
            return ""
        case .place:
            return "Place:"
        case .date:
            return "Date:"
        case .time:
            return "Time:"
        case .quantity:
            return "Quantity"
        case .discount:
            return "Discount"
        case .finalPrice:
            return "Final Price"
        }
        
    }
    
    func getValue(model: EventPresentationModel) -> String {
        switch(self) {
            
        case .name:
            return model.name
        case .description:
            return model.description
        case .place:
            return model.location
        case .date:
            return FormatUtils.formatDate(date: model.date)
        case .time:
            return FormatUtils.timeFromDate(date: model.date)
        case .quantity:
            return "\(model.quantity ?? 0)"
        case .discount:
            return FormatUtils.formatDiscount(discount: model.discount)
        case .finalPrice:
            if let discount = model.discount {
                return FormatUtils.formatPriceDecimal(price: FormatUtils.caclulatePriceWithDiscount(price: model.price, discount: discount))
            } else {
                return FormatUtils.formatPriceDecimal(price: model.price)
            }
            
        }
    }
    
    func getRowHeight() -> CGFloat {
        switch self {
        case .name:
            return 60
        case .description:
            return -1
        default:
            return 55
        }
    }
    
}

