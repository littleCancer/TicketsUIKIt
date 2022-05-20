//
//  DiscountItem.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 20.5.22..
//

import SwiftUI

struct DiscountItem: View {
    
    let discount: DiscountEntity
    
    var body: some View {
        VStack {
            DiscountCard(discount: discount)
                .background(EmptyView())
                .shadow(color: .gray.opacity(0.7), radius: 30, x: 0, y: 30)
            Text(discount.name!)
                .font(Font.appBoldFontOfSize(size: 23))
                .lineLimit(1)
                .padding(.top, 20)
        }
    }
}

struct DiscountItem_Previews: PreviewProvider {
    static var previews: some View {
        if let discount = CoreDataHelper.getTestDiscountEntity() {
            VStack {
                DiscountItem(discount: discount)
                    .frame(width: 220, height: 400)
            }
            .ignoresSafeArea()
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
              )
            .background(.blue)
            
        }
    }
}
