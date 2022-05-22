//
//  DiscountView.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 20.5.22..
//

import SwiftUI

struct DiscountView<Data>: View
where Data: RandomAccessCollection,
      Data.Element: DiscountEntity {
    
    var discounts: Data
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                Color.clear.frame(width: 7, height: 400)
                ForEach(discounts) { discount in
                    NavigationLink(destination: DetailsView(model: DetailsModel(discount: discount))) {
                        DiscountItem(discount: discount)
                            .frame(width: 220, height: 400)
                    }
                    
                }
                Color.clear.frame(width: 7, height: 400)
            }
        }
    }
}

struct DiscountView_Previews: PreviewProvider {
    static var previews: some View {
        if let discounts = CoreDataHelper.getTestDiscountEntities() {
            DiscountView(discounts: discounts)
        }
        
    }
}
