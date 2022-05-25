//
//  CellType.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 25.5.22..
//

import Foundation


enum AdminCellType {
    
    case filterCell
    case eventCell
    case actionCell
    
}

enum AdminSection {
    
    case filter
    case events
    case action
    
    
    func getSectionIndex() -> Int {
        switch (self) {
            
        case .filter:
            return 0
        case .events:
            return 1
        case .action:
            return 2
        }
    }
}
