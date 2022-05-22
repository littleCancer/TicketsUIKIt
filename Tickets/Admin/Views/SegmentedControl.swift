//
//  SegmentedControl.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 21.5.22..
//

import SwiftUI

struct SegmentedControl: View {
    
    @Binding var selectedTab:SelectedAdminTab
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35)
                .fill(Color.appBlue)
            VStack {

                HStack {
                    Button {
                        if (selectedTab != .NonDiscount) {
                            withAnimation {
                                selectedTab = .NonDiscount
                            }
                        }
                    } label: {
                        Text("Non-Discount")
                            .foregroundColor(.white)
                            .font(nonDiscountFont())
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)

                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 2, height: 35)
                    Button {
                        if (selectedTab != .Discount) {
                            withAnimation {
                                selectedTab = .Discount
                            }
                        }
                    } label: {
                        Text("Discount")
                            .foregroundColor(.white)
                            .font(discountFont())
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
                .frame(height: 50)
            }
        }
        .frame(height: 50)
    }
    
    private func nonDiscountFont() -> Font {
        if selectedTab == .NonDiscount {
            return Font.appBoldFontOfSize(size: 17)
        } else {
            return Font.appFontOfSize(size: 17)
        }
    }

    private func discountFont() -> Font {
        if selectedTab == .Discount {
            return Font.appBoldFontOfSize(size: 17)
        } else {
            return Font.appFontOfSize(size: 17)
        }
    }

}

struct SegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControl(selectedTab: .constant(.NonDiscount))
    }
}
