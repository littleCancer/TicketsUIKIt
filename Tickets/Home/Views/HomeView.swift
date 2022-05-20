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
        VStack {
            Divider()
                .frame(width: 300, height: 4).background(Color.appDividerGray())
            ScrollView(.vertical, showsIndicators: false) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(discounts) { discount in
                            Text(discount.name!)
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Concert tickets").font(Font.appBoldFontOfSize(size: 20))
            }
        }
        .task {
            if (!viewModel.hasDataInStorage) {
                await viewModel.fetchEvents()
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
