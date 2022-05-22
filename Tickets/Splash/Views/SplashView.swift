//
//  SplashView.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 18.5.22..
//

import SwiftUI

struct SplashView: View {
    
    private let requestManager = RequestManager()
    @State private var isAnimating = false
    @State private var angle: CGFloat = 200.0
    
    var animation: Animation {
            Animation.easeOut(duration: 1.0)
                .repeatForever(autoreverses: true)
        }
    
    var body: some View {
        VStack {
            Text("Concert tickets")
                .font(Font.appBoldFontOfSize(size: 30))
            Image(systemName: "hourglass")
                .resizable()
                .frame(width: 25, height: 30)
                .foregroundColor(.indigo)
                .rotationEffect(Angle.degrees(isAnimating ? angle : 0))
                .animation(animation, value: isAnimating)
                            .onAppear { self.isAnimating = true }
                            .onDisappear { self.isAnimating = false }
                            
            
        }
        .ignoresSafeArea()
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center
          )
        .background(Color.appGray)
    }
    
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
