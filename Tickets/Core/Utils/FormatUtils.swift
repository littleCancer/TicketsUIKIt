//
//  FormatUtils.swift
//  Tickets
//
//  Created by Stevan Rakic on 19.5.22..
//

import Foundation


enum FormatUtils {
    
    
    static func formatDiscount(discount: NSDecimalNumber?) -> String {
        if let discount = discount {
            return "-\(discount)%"
        }
        return ""
    }
    
    static func formatAvailabilityMessage(amount: NSDecimalNumber?, quantity: Int16?) -> String {
        guard let amount = amount, let quantity = quantity else {
            return ""
        }
        
        return "Only \(quantity) tickets for \(amount)€"

    }
    
}
