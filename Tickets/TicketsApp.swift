//
//  TicketsApp.swift
//  Shared
//
//  Created by Stevan Rakic on 18.5.22..
//

import SwiftUI

@main
struct TicketsApp: App {
    let persistenceController = PersistenceController.shared
    @State var showSplash = true

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .fullScreenCover(isPresented: $showSplash) {
                    SplashView()
                        .task {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                              showSplash = false
                            }
                        }
                }
        }
    }
}
