//
//  FontUtils.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 18.5.22..
//

import Foundation
import SwiftUI

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

extension UIFont {
    static func appFontOfSize(size: CGFloat) -> UIFont? {
        return UIFont(name: AppFonts.Montserrat.name(), size: size)
    }
    
    static func appBoldFontOfSize(size: CGFloat) -> UIFont? {
        return UIFont(name: AppFonts.MontserratBold.name(), size: size)
    }
}
