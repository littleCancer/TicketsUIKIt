//
//  TextWithHeading.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 20.5.22..
//

import SwiftUI

struct TextWithHeading: View {
    
    let heading: String
    let info: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(heading)
                    .modifier(NormalTextModifier())
                    .padding(0)
                    .frame(height: 12)
                Text(info)
                    .modifier(BoldTextModifier())
                    .padding(0)
                    .frame(height: 12)
            }
            Spacer()
        }
    }
}

struct NormalTextModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
          .padding(4)
          .foregroundColor(Color.gray)
          .font(Font.appFontOfSize(size: 12))
      }
    
}

struct BoldTextModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
          .padding(4)
          .foregroundColor(Color.black)
          .font(Font.appBoldFontOfSize(size: 12))
      }
    
}

struct TextWithHeading_Previews: PreviewProvider {
    static var previews: some View {
        TextWithHeading(heading: "Place:", info: "Jakarta")
    }
}
