//
//  DetailsView.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 20.5.22..
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    let model: DetailsModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                WebImage(url: URL(string: model.imageUrl))
                    .resizable()
                    .placeholder(content: {
                        Color.appGray
                    })
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: 250)
                    .transition(.fade(duration: 0.3))
                    .offset(y: -220)
                    
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .frame(height: geometry.size.height * 0.67)

                    VStack(spacing: 10) {
                        Text(model.name)
                            .font(Font.appBoldFontOfSize(size: 30))
                            .foregroundColor(.black)
                            .padding(.top, 30)
                        if let description = model.description, !description.isEmpty {
                            Text(description)
                                .lineLimit(10)
                                .fixedSize(horizontal: false, vertical: true)
                                .scaledToFit()
                                .modifier(NormalTextModifier())
                        }
                        
                        TextWithHeading(heading: "Place:", info: model.place)
                            .padding(.top, 8)
                        TextWithHeading(heading: "Date:", info: model.date)
                            .padding(.top, 8)
                        TextWithHeading(heading: "Quantity:", info: model.quantity)
                            .padding(.top, 8)
                        if let discount = model.discount {
                            TextWithHeading(heading: "Discount:", info: discount)
                                .padding(.top, 8)
                        }
                        TextWithHeading(heading: "Final Price:", info: model.finalPrice)
                            .padding(.top, 8)
                        Spacer()
                        
                    }
                    .frame(height: geometry.size.height * 0.67)
                    .padding(20)
                    
                }
                .frame(height: geometry.size.height * 0.67)
                .padding(30)
                .offset(y: 110)
                .shadow(color: .gray, radius: 20, x: 0, y: 10)
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.appGray)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }

                }
                ToolbarItem(placement: .principal) {
                    Text("Details").font(Font.appBoldFontOfSize(size: 25))
                }
            }
        }.onAppear{
            UINavigationBar.appearance().barTintColor = UIColor(.black)
        }

    }
}

struct DetailsModel {
    var name: String = ""
    var description: String?
    var place: String = ""
    var date: String = ""
    var quantity: String = ""
    var discount: String?
    var finalPrice: String = ""
    var imageUrl: String = ""
    
    init(discount: DiscountEntity) {
        if let name = discount.name {
            self.name = name
        }
        
        if let description = discount.eventDescription {
            self.description = description
        }
        
        if let place = discount.place {
            self.place = place
        }
        
        if let date = discount.date {
            self.date = FormatUtils.formatDate(date: date)
        }
    
        self.quantity = String(discount.quantity)
        
        if let discount = discount.discount {
            self.discount = FormatUtils.formatDiscountForDetail(discount: discount)
        }
        
        if let price = discount.price, let discount = discount.discount {
            let finalPrice = FormatUtils.caclulatePriceWithDiscount(price: price, discount: discount)
            self.finalPrice = FormatUtils.formatPrice(price: finalPrice as NSDecimalNumber)
        }
        
        if let photo = discount.photo {
            self.imageUrl = ApiUtils.getImageUrl(imagePath: photo)
        }
    }
    
    init(event: EventEntity) {
        if let name = event.name {
            self.name = name
        }
        
        if let description = event.eventDescription {
            self.description = description
        }
        
        if let place = event.place {
            self.place = place
        }
        
        if let date = event.date {
            self.date = FormatUtils.formatDate(date: date)
        }
    
        self.quantity = String(event.quantity)
        
        if let price = event.price {
            self.finalPrice = FormatUtils.formatPrice(price: price)
        }
        
        if let photo = event.photo {
            self.imageUrl = ApiUtils.getImageUrl(imagePath: photo)
        }
    }
    
}


struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        if let discount = CoreDataHelper.getTestDiscountEntity() {
            VStack {
                DetailsView(model: DetailsModel(discount: discount))
            }
            .background(.blue)
            
        }
        
    }
}
