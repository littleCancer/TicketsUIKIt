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
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
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
    
    static func formatAvailabilityMessage(amount: Float, quantity: Int16?) -> String {
        guard let quantity = quantity else {
            return ""
        }
        
        let price = FormatUtils.formatPrice(price: amount)
        return "Only \(quantity) tickets for \(price)"

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
        return "\(priceRounded)€"
    }
    
    static func formatPriceDecimal(price: Float?) -> String {
        guard let price = price else {
            return ""
        }
        
        return String(format: "%.2f€", price)
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
    
    static func caclulatePriceWithDiscount(price: Float, discount: Int16) -> Float {
        let discountAmount = price * Float(discount) / 100
        let finalPrice = price - discountAmount
        return finalPrice
    }
    
    static func decimal(with string: String) -> NSDecimalNumber {
        return decimalFormater.number(from: string) as? NSDecimalNumber ?? 0
    }
    
    static func date(from value:String) -> Date {
        return fullDateFormatter.date(from: value) ?? Date.now
    }
    
}

