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
    

    var body: some Scene {
        WindowGroup {
            ContentView()
                .id(AppState.shared.appID)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

class AppState: ObservableObject {
    static let shared = AppState()

    @Published var appID = UUID()
}
