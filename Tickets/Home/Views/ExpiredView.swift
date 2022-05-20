//
//  ExpiredView.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 20.5.22..
//

import SwiftUI

struct ExpiredView<Data>: View
where Data: RandomAccessCollection,
      Data.Element: DiscountEntity {
    
    let discounts: Data
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                Color.clear.frame(width: 7, height: 200)
                ForEach(discounts) { discount in
                    NavigationLink(destination: DetailsView(model: DetailsModel(discount: discount))) {
                        ExpiredCard(discount: discount)
                            .frame(width: 160, height: 160)
                            .shadow(color: .gray.opacity(0.7), radius: 8, x: 0, y: 8)
                    }
                }
                Color.clear.frame(width: 7, height: 200)
            }
        }
    }
}

struct ExpiredView_Previews: PreviewProvider {
    static var previews: some View {
        if let discounts = CoreDataHelper.getTestDiscountEntities() {
            ExpiredView(discounts: discounts)
        }
        
    }
}
