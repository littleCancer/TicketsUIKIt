//
//  FormatUtils.swift
//  Tickets
//
//  Created by Stevan Rakic on 19.5.22..
//

import Foundation


enum FormatUtils {
    
    static let fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    static let decimalFormater:NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        return formatter
    }()
    
    static func formatDiscount(discount: Int16?) -> String {
        if let discount = discount {
            return "-\(discount)%"
        }
        return ""
    }
    
    static func formatDiscountForDetail(discount: NSDecimalNumber?) -> String {
        if let discount = discount {
            return "-\(discount)%"
        }
        return ""
    }
    
    static func formatAvailabilityMessage(amount: Int16?, quantity: Int16?) -> String {
        guard let amount = amount, let quantity = quantity else {
            return ""
        }
        
        return "Only \(quantity) tickets for \(amount)€"

    }
    
    static func formatTicketsLeftMessage(quantity: Int16?) -> String {
        guard let quantity = quantity else {
            return ""
        }
        
        return "\(quantity) tickets more"

    }
    
    static func formatPrice(price: Float?) -> String {
        guard let price = price else {
            return ""
        }
        
        let priceRounded = Int(price)
        return "\(priceRounded)e"
    }
    
    static func monthFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date).uppercased()
    }
    
    static func yearFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func timeFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    static func dayOfTheMonthFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
    
    static func formatDate(date: Date) -> String {
        return fullDateFormatter.string(from: date)
    }
    
    static func caclulatePriceWithDiscount(price: NSDecimalNumber, discount: NSDecimalNumber) -> NSDecimalNumber {
        let discountAmount = (price as Decimal) * (discount as Decimal) / 100
        let finalPrice = (price as Decimal) - discountAmount
        return  finalPrice as NSDecimalNumber
    }
    
    static func decimal(with string: String) -> NSDecimalNumber {
        return decimalFormater.number(from: string) as? NSDecimalNumber ?? 0
    }
    
}
