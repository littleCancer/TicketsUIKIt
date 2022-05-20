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
        predicate: NSPredicate(format: "date > %@", argumentArray: [NSDate.now]),
        animation: .default
    )
    private var discounts: FetchedResults<DiscountEntity>
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \DiscountEntity.date, ascending: true)
        ],
        predicate: NSPredicate(format: "date < %@", argumentArray: [NSDate.now]),
        animation: .default
    )
    private var expired: FetchedResults<DiscountEntity>
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \EventEntity.date, ascending: true)
        ],
        predicate: NSPredicate(format: "date > %@", argumentArray: [NSDate.now]),
        animation: .default
    )
    private var upcoming: FetchedResults<EventEntity>
    
    var body: some View {
        VStack {
            Rectangle().fill(Color.appDividerGray).frame(width: 300, height: 3)
                .padding(.top, 5)
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        Text("For you")
                            .modifier(SectioTextModifier())
                        Spacer()
                    }
                    DiscountView(discounts: discounts)
                    
                    HStack {
                        Text("Upcoming")
                            .modifier(SectioTextModifier())
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    UpcomingView(events: upcoming)
                    
                    HStack {
                        Text("Expired")
                            .modifier(SectioTextModifier())
                        Spacer()
                    }
                    .padding(.top, 20)
                    ExpiredView(discounts: expired)
                    
                    HStack {
                        Spacer()
                        NavigationLink {
                            Text("Baraba")
                        } label: {
                            Image(systemName: "pencil.circle.fill")
                                .resizable()
                                .foregroundColor(.blue)
                                .frame(width: 40, height: 40)
                        }
                        .padding(.trailing, 30)

                    }
                }
                
            }
        }
        .background(Color.appGray)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Concert tickets").font(Font.appBoldFontOfSize(size: 25))
            }
        }
        .task {
            if (!viewModel.hasDataInStorage) {
                await viewModel.fetchEvents()
            }
        }
    }
    
}

struct SectioTextModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(Font.appBoldFontOfSize(size: 30))
            .foregroundColor(.black)
            .padding(.bottom, 20)
            .padding(.leading, 40)
            .padding(.top, 20)
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
