//
//  EventView.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 20.5.22..
//

import SwiftUI
import SDWebImageSwiftUI

struct EventView: View {
        
    var event: EventViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 35))
                    .background(EmptyView())
                    .shadow(color: .gray.opacity(0.7), radius: 20, x: 0, y: 20)
                
                HStack {
                    VStack {
                        Text(event.month)
                            .font(Font.appFontOfSize(size: 20))
                            .foregroundColor(.black)
                            .scaledToFit()
                            .minimumScaleFactor(0.01)
                        Text(event.dayOfMonth)
                            .font(Font.appBoldFontOfSize(size: 50))
                            .foregroundColor(.black)

                        Text(event.year)
                            .font(Font.appFontOfSize(size: 20))
                            .foregroundColor(.black)
                    }
                    .frame(width: 100)

                    
                    ZStack {
                        WebImage(url: URL(string: event.imageUrl))
                            .resizable()
                            .placeholder(content: {
                                Color.appGray
                            })
                            .clipShape(RoundedRectangle(cornerRadius: 35))
                            .transition(.fade(duration: 0.3))
                            .frame(width: geometry.size.width * 0.7,
                                   height: geometry.size.height * 0.8)
                        VStack {
                            HStack {
                                RoundedTextView(text: event.name, font: Font.appFontOfSize(size: 15))
                                    .frame(width: 130, height: 40)
                                Spacer()
                                if let discountText = event.discountText {
                                    RoundedTextView(text: discountText, font: Font.appFontOfSize(size: 15))
                                        .frame(width: 50, height: 40)
                                }
                            }
                            .padding(.top, 10)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            HStack {
                                VStack(alignment: .leading) {
                                    if let time = event.time {
                                        Text(time)
                                            .font(Font.appBoldFontOfSize(size: 17))
                                            .foregroundColor(.white)
                                    }
                                    Text(event.location)
                                        .font(Font.appBoldFontOfSize(size: 17))
                                        .foregroundColor(.white)
                                    Text(event.ticketsLeftText)
                                        .font(Font.appFontOfSize(size: 17))
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                        .scaledToFit()
                                        .minimumScaleFactor(0.01)
                                }
                                .padding(.leading, 20)
                                Spacer()
                                
                                RoundedTextView(text: event.priceText, font: Font.appFontOfSize(size: 30))
                                    .frame(width: 90, height: 60)
                                    .padding(.trailing, 20)
                            }
                            .padding(.top, 35)
                        }
                    }
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 10))
                }
            }
            .frame(width: geometry.size.width)
        }
    }
}

struct EventViewModel {
    
    var id: Int64
    var month: String = ""
    var dayOfMonth: String = ""
    var year: String = ""
    var name: String = ""
    var discountText: String?
    var time: String?
    var location: String = ""
    var ticketsLeftText: String = ""
    var priceText: String = ""
    var imageUrl: String = ""
    
    init(event: EventEntity) {
        
        self.id = event.id
        if let date = event.date {
            self.month = FormatUtils.monthFromDate(date: date)
            self.dayOfMonth = FormatUtils.dayOfTheMonthFromDate(date: date)
            self.year = FormatUtils.yearFromDate(date: date)
        }
        
        if let name = event.name {
            self.name = name
        }
        
        if let location = event.place {
            self.location = location
        }
        
        if let photo = event.photo {
            self.imageUrl = ApiUtils.getImageUrl(imagePath: photo)
        }
        
        self.ticketsLeftText = FormatUtils.formatTicketsLeftMessage(quantity: event.quantity)
        self.priceText = FormatUtils.formatPrice(price: event.price)
    }
    
    init(discount: DiscountEntity) {
        
        self.id = discount.id
        if let date = discount.date {
            self.month = FormatUtils.monthFromDate(date: date)
            self.dayOfMonth = FormatUtils.dayOfTheMonthFromDate(date: date)
            self.year = FormatUtils.yearFromDate(date: date)
        }
        
        if let name = discount.name {
            self.name = name
        }
        
        self.discountText = FormatUtils.formatDiscount(discount: discount.discount)
        
        if let location = discount.place {
            self.location = location
        }
        
        if let photo = discount.photo {
            self.imageUrl = ApiUtils.getImageUrl(imagePath: photo)
        }
        
        self.ticketsLeftText = FormatUtils.formatTicketsLeftMessage(quantity: discount.quantity)
        self.priceText = FormatUtils.formatPrice(price: discount.price)
    }
    
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        
            VStack {
                if let event = CoreDataHelper.getTestEventEntity() {
                    EventView(event: EventViewModel(event: event))
                        .frame(height: 220)
                        .padding(.bottom, 40)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                }
                
                if let discount = CoreDataHelper.getTestDiscountEntity() {
                    EventView(event: EventViewModel(discount: discount))
                        .frame(height: 220)
                        .padding(.bottom, 40)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                }
                
                if let discount2 = CoreDataHelper.getTestDiscountEntity() {
                    EventView(event: EventViewModel(discount: discount2))
                        .frame(height: 220)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                }
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


