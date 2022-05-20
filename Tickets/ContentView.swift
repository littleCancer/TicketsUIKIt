//
//  ContentView.swift
//  Shared
//
//  Created by Stevan Rakic on 18.5.22..
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var showSplash = true

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        
        
        
        ZStack {
            if (showSplash) {
                SplashView()
                    .transition(.asymmetric(insertion: .identity, removal: .move(edge: .bottom)))
                    .task {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.easeIn(duration: 0.2)) {
                                showSplash.toggle()
                            }
                        }
                    }
            } else {
                NavigationView {
                    HomeView(viewModel: HomeViewModel(eventsFetcher: FetchEventsService(requestManager: RequestManager()), eventsStore: EventsStoreService(context: PersistenceController.shared.container.newBackgroundContext())))
        //            HomeView(
        //                viewModel: HomeViewModel(
        //                    eventsFetcher: EventsFetcherMock(),
        //                    eventsStore: EventsStoreService(context: PersistenceController.preview.container.viewContext)))
                }
            }
        }
        
        
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
