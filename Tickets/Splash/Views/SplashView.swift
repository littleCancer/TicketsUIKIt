//
//  SplashView.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 18.5.22..
//

import SwiftUI

struct SplashView: View {
    
    private let requestManager = RequestManager()
    
    var body: some View {
        VStack {
            Text("Concert tickets")
                .font(Font.appBoldFontOfSize(size: 30))
            Image(systemName: "hourglass")
                .resizable()
                .frame(width: 25, height: 30)
                .foregroundColor(.indigo)
            
        }
        .ignoresSafeArea()
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center
          )
        .background(Color("AppGray"))
    }
    
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
