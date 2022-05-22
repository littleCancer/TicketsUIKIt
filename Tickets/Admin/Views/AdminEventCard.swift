//
//  AdminEventCard.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 21.5.22..
//

import SwiftUI
import CoreData

struct AdminEventCard: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    var eventDiscountPair: EventDiscountPair
    @Binding var selectedTab:SelectedAdminTab
    var deleter: (EventDiscountPair) -> Void
    
    @State var showEditView = false
    @State var showDeletePrompt = false
    
    private var deleteSheetTitle: String {
        if self.selectedTab == .NonDiscount {
            return "Delete event?"
        } else {
            return "Delete discount for event?"
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 35)
                        .fill(Color.appBlue)
                        .padding(.horizontal, 10)
                        .shadow(color: .gray.opacity(0.7), radius: 20, x: 0, y: 20)
                    
                    VStack {
                        Spacer()
                        HStack {
                            Button {
                                self.showEditView.toggle()
                            } label: {
                                Text("Edit")
                                    .foregroundColor(.white)
                                    .font(Font.appBoldFontOfSize(size: 20))
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)

                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 2, height: 35)
                            Button {
                                showDeletePrompt.toggle()
                            } label: {
                                Text("Delete")
                                    .foregroundColor(.white)
                                    .font(Font.appBoldFontOfSize(size: 20))
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .confirmationDialog(deleteSheetTitle, isPresented: $showDeletePrompt, titleVisibility: .visible) {
                                            Button("Delete", role: .destructive) {
                                                withAnimation {
                                                    deleter(eventDiscountPair)
                                                }
                                            }
                                        }
                        }
                        .frame(height: 50)
                    }
                }

                .frame(height: 200)
                
                
                if (selectedTab == .NonDiscount) {
                    EventView(event: EventViewModel(event: eventDiscountPair.event), showShadow: false)
                        .padding(.horizontal, 10)
                        .frame(height: 200)
                        .offset(y: -50)
                } else if let discount = eventDiscountPair.discount {
                    EventView(event: EventViewModel(discount:discount), showShadow: false)
                        .padding(.horizontal, 10)
                        .frame(height: 200)
                        .offset(y: -50)
                }
                NavigationLink(destination: EditEventView(viewModel: EditEventViewModel(context: viewContext, eventDiscountPair: eventDiscountPair)), isActive: $showEditView) {
                    EmptyView()
                }
            }
            .frame(width: geometry.size.width)
        }
        
    }
}

struct AdminEventCard_Previews: PreviewProvider {
    static var previews: some View {
        
        if let event = CoreDataHelper.getTestEventEntity(id: 7), let discount = CoreDataHelper.getTestDicountEntity(id: 7) {
            let pair = EventDiscountPair(event: event, discount: discount)
            AdminEventCard(eventDiscountPair: pair, selectedTab: .constant(SelectedAdminTab.NonDiscount)) { _ in
                
            }
        }
        
    }
}
