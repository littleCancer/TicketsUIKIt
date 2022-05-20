//
//  ElipseTextView.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 19.5.22..
//

import SwiftUI

struct RoundedTextView: View {
    
    let text: String
    let font: Font
    
    var body: some View {
        
        ZStack {
            Capsule()
                .fill(.white.opacity(0.7))
            Text(text)
                .font(font)
                .foregroundColor(.black)
        }
    }
}

struct ElipseTextView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RoundedTextView(text: "153 e", font: Font.appFontOfSize(size: 30))
                .frame(width: 100, height: 100)
            RoundedTextView(text: "-40 %", font: Font.appFontOfSize(size: 40))
                .frame(width: 200, height: 160)
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
