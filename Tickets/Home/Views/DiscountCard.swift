//
//  DiscountCard.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 19.5.22..
//

import SwiftUI
import SDWebImageSwiftUI

struct DiscountCard: View {
    
    let discount: DiscountEntity
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                WebImage(url: URL(string: discount.imageUrl))
                    .resizable()
                    .placeholder(content: {
                        Color("AppGray")
                    })
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 45))
                    .transition(.fade(duration: 0.3))
                
                VStack {
                    RoundedTextView(text: FormatUtils.formatDiscount(discount: discount.discount), font: Font.appBoldFontOfSize(size: 30))
                        .frame(width: 100, height: 85)
                        .padding(.top, 20)
                    Spacer()
                    BottomInfoView(location: discount.place, date: discount.date, message: FormatUtils.formatAvailabilityMessage(amount: discount.price, quantity: discount.quantity))
                        .frame(width: geometry.size.width, height: geometry.size.height / 2.5)
                }
                .clipShape(RoundedRectangle(cornerRadius: 45))
            }
        }

    }
}


struct BottomInfoView: View {
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    var location: String?
    var date: Date?
    var message: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 45))
            VStack {
                Label {
                    Text(location ?? "")
                        .font(Font.appBoldFontOfSize(size: 25))
                        .foregroundColor(.white)
                } icon: {
                    Image("map-pin")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .padding(0)
        
                Text("\(date!, formatter: dateFormatter)")
                    .font(Font.appBoldFontOfSize(size: 20))
                    .foregroundColor(.white)
                    .padding(.top, 1)
                
                Text(message)
                    .font(Font.appFontOfSize(size: 15))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .padding(.top, 1)
            }
        }
        
    }
    
    
}


struct DiscountCard_Previews: PreviewProvider {
    static var previews: some View {
        if let discount = CoreDataHelper.getTestDiscountEntity() {
            VStack {
                DiscountCard(discount: discount)
                    .frame(width: 220, height: 350)
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
