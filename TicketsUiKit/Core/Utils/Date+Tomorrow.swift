//
//  File.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 26.5.22..
//

import Foundation


extension NSDate {
    
    static func tomorrow() -> NSDate {
        return NSDate(timeInterval: (24*60*60), since: NSDate.now)
    }
    
}
