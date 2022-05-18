//
//  FontUtils.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 18.5.22..
//

import Foundation
import SwiftUI

struct FontUtils {
    
    enum AppFonts {
        case Montserrat
        case MontserratBold
        
        func name() -> String {
            switch self {
            case .Montserrat:
                 return "Montserrat-Regular"
            case .MontserratBold:
                return "Montserrat-Bold"
            }
        }
    }
    
    static func appFontOfSize(size: CGFloat) -> Font {
        return Font.custom(AppFonts.Montserrat.name(), size: size)
    }
    
    static func appBoldFontOfSize(size: CGFloat) -> Font {
        return Font.custom(AppFonts.MontserratBold.name(), size: size)
    }
    
    
}
