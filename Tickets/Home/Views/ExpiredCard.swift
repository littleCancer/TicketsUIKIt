//
//  ExpiredCard.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 20.5.22..
//

import SwiftUI
import SDWebImageSwiftUI

struct ExpiredCard: View {
    
    let discount: DiscountEntity
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                WebImage(url: URL(string: discount.imageUrl))
                    .resizable()
                    .placeholder(content: {
                        Color.appGray
                    })
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 35))
                    .transition(.fade(duration: 0.3))
                
                VStack {
                    RoundedTextView(text: FormatUtils.formatDiscount(discount: discount.discount), font: Font.appFontOfSize(size: 20))
                        .frame(width: 60, height: 55)
                        .padding(.top, 15)
                    Spacer()
                    RoundedTextView(text: discount.name!, font: Font.appFontOfSize(size: 15))
                        .frame(height: 22)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    if let place = discount.place {
                        Text(place)
                            .font(Font.appBoldFontOfSize(size: 15))
                            .foregroundColor(.white)
                    }
                    Color.clear.frame(height: 1)
                    
                }
                .clipShape(RoundedRectangle(cornerRadius: 35))
            }
        }
    }
}

struct ExpiredCard_Previews: PreviewProvider {
    static var previews: some View {
        if let discount = CoreDataHelper.getTestDiscountEntity() {
            VStack {
                ExpiredCard(discount: discount)
                    .frame(width: 220, height: 220)
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
