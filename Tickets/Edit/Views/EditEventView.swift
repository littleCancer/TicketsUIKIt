//
//  SwiftUIView.swift
//  Tickets
//
//  Created by Stevan Rakic on 21.5.22..
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit

struct EditEventView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: EditEventViewModel
    
    var updateButtonColor: Color {
        return viewModel.disableForm ? .gray : .white
    }
    
    var dicsountQuantityBottomPadding: CGFloat {
        viewModel.isDiscountQuantityValid ? 20 : 10
    }
    
    var body: some View {

            Form {
                WebImage(url: URL(string: viewModel.imageURL))
                    .resizable()
                    .placeholder(content: {
                        Color.appGray
                    })
                    .scaledToFill()
                    .frame(height: 250)
                    .transition(.fade(duration: 0.3))
                    .padding(.leading, -50)
                    .padding(.trailing, -50)
   
                Section("Name:") {
                    TextField("Name", text: $viewModel.name)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.appDividerGray, lineWidth: 1)
                                    .frame(width: 341, height: 43)
                        )
                    if !viewModel.isNameValid {
                        RequirementText(text: "A name is required")
                    }

                }
                .textCase(nil)
                
                Section("Description:") {
                    TextEditor(text: $viewModel.eventDescription)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)
                                    .padding(.horizontal, -5)
                                    .clipped()
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.appDividerGray, lineWidth: 1)
                                                .frame(width: 341)
                                                .frame(maxHeight: .infinity)
                                                .padding(-5)
                                    )
                }
                .textCase(nil)
                
                Section("Place:") {
                    TextField("Place", text: $viewModel.place)
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.appDividerGray, lineWidth: 1)
                                .frame(width: 341, height: 43)
                    )
                    if !viewModel.isPlaceValid {
                        RequirementText(text: "A location is required")
                    }
            
                        
                }
                .textCase(nil)
                
                Section("Date:") {
                    DatePicker("Date", selection: $viewModel.date, in: Date()...)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.appDividerGray, lineWidth: 1)
                                    .frame(width: 341, height: 45)
                        )
                }
                .textCase(nil)
                
                Section("Price:") {
                    TextField("Price", text: $viewModel.price)
                        .keyboardType(.decimalPad)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.appDividerGray, lineWidth: 1)
                                    .frame(width: 341, height: 43)
                        )
                    if !viewModel.isPriceValid {
                        RequirementText(text: "A price is required")
                    }
                }.textCase(nil)
                
                Section("Quantity:") {
                    TextField("Quantity", text: $viewModel.quantity)
                        .keyboardType(.numberPad)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.appDividerGray, lineWidth: 1)
                                    .frame(width: 341, height: 43)
                        )
                    if !viewModel.isQuantityValid {
                        RequirementText(text: "A quantity is required")
                    }
                }
                .textCase(nil)
                
                Section() {
                    Toggle(isOn: $viewModel.discountOn.animation()) {
                        Text("Discount")
                    }
                    .tint(Color.appBlue)
                }
                
                if (viewModel.discountOn) {
                    Section {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.appBlue)
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Discount value:")
                                        .font(Font.appFontOfSize(size: 15))
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                .padding(.top, 10)
                                TextField("Value", text: $viewModel.discount)
                                    .keyboardType(.decimalPad)
                                    .listRowBackground(Color.white)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.white)
                                            .frame(height: 45)
                                    }
                                    .padding(.top, 5)
                                if !viewModel.isDiscountValid {
                                    RequirementText(text: "Enter valid quantity", foregroundColor: .white)
                                        .padding(.top, 5)
                                }
                                
                                HStack {
                                    Text("Discount quantity:")
                                        .font(Font.appFontOfSize(size: 15))
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                .padding(.top, 10)
                                
                                TextField("Quantity", text: $viewModel.discountQuantity)
                                    .keyboardType(.numberPad)
                                    .listRowBackground(Color.white)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.white)
                                            .frame(height: 45)
                                    }
                                    .padding(.top, 10)
                                    .padding(.bottom, dicsountQuantityBottomPadding)
                                
                                if !viewModel.isDiscountQuantityValid {
                                    RequirementText(text: "Enter valid quantity", foregroundColor: .white)
                                        .padding(.bottom, 5)
                                }
                                
                            }
                        }
                        .transition(.scale)
                    }.listRowBackground(Color.appBlue)
                    
  
                }
                
                Section() {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.appBlue).scaledToFill()
                        Button(getButtonText()) {
                            self.viewModel.saveChanges()
                            dismiss()
                        }
                        .foregroundColor(updateButtonColor)
                        .disabled(viewModel.disableForm)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .font(Font.appBoldFontOfSize(size: 20))
                }
                .listRowBackground(Color.appBlue)
            }
            .accentColor(.white)
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
                    Text(getButtonText()).font(Font.appBoldFontOfSize(size: 25))
                }
            }
            .onAppear {
                UITableView.appearance().showsVerticalScrollIndicator = false
                UITableView.appearance().backgroundColor = .white
            }
        
    }
    
    
    func priceValidator(newValue: String) {
        if newValue.range(of: "^\\d+$", options: .regularExpression) != nil {
            viewModel.price = newValue
        } else if !self.viewModel.price.isEmpty {
            viewModel.price = String(newValue.prefix(viewModel.price.count - 1))
        }
    }
    
    private func getButtonText() -> String {
        viewModel.eventDiscountPair != nil ? "Update" : "Create"
    }
}

struct EditEventView_Previews: PreviewProvider {
    static var previews: some View {
        if let event = CoreDataHelper.getTestEventEntity(id: 7), let discount = CoreDataHelper.getTestDicountEntity(id: 7) {
            let pair = EventDiscountPair(event: event, discount: discount)
            EditEventView(viewModel: EditEventViewModel(context: PersistenceController.preview.container.viewContext, eventDiscountPair: pair))
        }
    }
}
