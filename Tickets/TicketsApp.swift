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
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
