//
//  HomeView.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 19.5.22..
//

import SwiftUI

struct HomeView: View {
    
    
    @ObservedObject var viewModel: HomeViewModel
    
    @State var showSplash = true
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \DiscountEntity.date, ascending: true)
        ],
        animation: .default
    )
    private var discounts: FetchedResults<DiscountEntity>
    
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .task {
                    if (!viewModel.hasDataInStorage) {
                        await viewModel.fetchEvents()
                    }
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            viewModel: HomeViewModel(
                eventsFetcher: EventsFetcherMock(),
                eventsStore: EventsStoreService(context: PersistenceController.preview.container.viewContext))
        )
    }
}
