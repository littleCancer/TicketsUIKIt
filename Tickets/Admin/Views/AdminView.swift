//
//  AdminView.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 21.5.22..
//

import SwiftUI

struct AdminView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AdminViewModel
    
    @State var showDestroyPrompt = false
    
    var body: some View {
        VStack {
            Rectangle().fill(Color.appDividerGray).frame(width: 300, height: 3)
                .padding(.top, 5)
            
            SegmentedControl(selectedTab: $viewModel.selectedTab)
                .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .center, spacing: 80) {
                    ForEach(viewModel.eventDiscountPairs, id: \.event.id) { pair in
                        if (viewModel.selectedTab == .NonDiscount ||
                            pair.discount != nil) {
                            AdminEventCard(eventDiscountPair: pair, selectedTab: $viewModel.selectedTab, deleter: viewModel.deleteEntity)
                                .frame(height: 200)
                        }
                    }
                }
                .padding(.top, 50)
                .animation(.spring(), value: viewModel.eventDiscountPairs)
                
                HStack {
                    Spacer()
                    
                    Button {
                        showDestroyPrompt.toggle()
                    } label: {
                        Image(systemName: "minus.rectangle.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.appBlue)
                                    .frame(width: 45, height: 45)

                            }
                    }
                    .padding(.trailing, 30)
                    .confirmationDialog("Erase all data?", isPresented: $showDestroyPrompt, titleVisibility: .visible) {
                                    Button("Delete", role: .destructive) {
                                        Task {
                                            await CoreDataHelper.clearDatabase()
                                            UserDefaults.standard.set(false, forKey: "hasDataStored")
                                            UserDefaults.standard.synchronize()
                                            AppState.shared.appID = UUID()
                                            dismiss()
                                        }
                                    }
                                }

                    
                    NavigationLink(destination: EditEventView(viewModel: EditEventViewModel(context: viewContext, eventDiscountPair: nil))) {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.appBlue)
                                    .frame(width: 45, height: 45)

                            }
                    }

                }
                .padding(.top, 100)
                .padding(.trailing, 30)
            }
            .id(viewModel.scrollViewID)
        }
        .background(Color.appGray)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }

            }
            ToolbarItem(placement: .principal) {
                Text("Admin").font(Font.appBoldFontOfSize(size: 25))
            }
        }
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView(viewModel: AdminViewModel(context: PersistenceController.preview.container.viewContext))
    }
}
