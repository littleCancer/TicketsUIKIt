//
//  DiscountCard.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 19.5.22..
//

import SwiftUI

struct DiscountCard: View {
    
    let discount: DiscountEntity
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DiscountCard_Previews: PreviewProvider {
    static var previews: some View {
        if let discount = CoreDataHelper.getTestDiscountEntity() {
            DiscountCard(discount: discount)
        }
    }
}
