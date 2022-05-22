//
//  EditEventViewModel.swift
//  Tickets
//
//  Created by Stevan Rakic on 21.5.22..
//

import Foundation
import Alamofire
import Combine
import CoreVideo
import CoreData

@MainActor
class EditEventViewModel: ObservableObject {
    
    let context: NSManagedObjectContext
    var eventDiscountPair: EventDiscountPair?
    
    @Published var name: String = ""
    @Published var eventDescription = ""
    @Published var place = ""
    @Published var date = Date()
    @Published var price = ""
    @Published var quantity = ""
    @Published var discount = ""
    @Published var discountQuantity = ""
    
    @Published var isNameValid = false
    @Published var isPlaceValid = false
    @Published var isPriceValid = false
    @Published var isQuantityValid = false
    @Published var isDiscountQuantityValid = false
    @Published var isDiscountValid = false
    
    var disableForm: Bool {
        !isNameValid || !isPriceValid || !isPlaceValid || !isQuantityValid
        || (discountOn && !isDiscountValid) || (discountOn && !isDiscountQuantityValid)
    }
    
    @Published var discountOn = false
    private var cancellableSet: Set<AnyCancellable> = []
    
    var imageURL: String {
        if let photo = eventDiscountPair?.event.photo {
            return ApiUtils.getImageUrl(imagePath: photo)
        } else {
            return ApiUtils.getImageUrl(imagePath: "/images/Concert.jpg")
        }
    }
    
    init(context: NSManagedObjectContext, eventDiscountPair: EventDiscountPair?) {
        self.context = context
        if let pair = eventDiscountPair {
            self.eventDiscountPair = pair
            
            self.name = pair.event.name ?? ""
            self.eventDescription = pair.event.eventDescription ?? ""
            self.place = pair.event.place ?? ""
            self.date = pair.event.date ?? Date()
            self.price = "\(pair.event.price ?? 0)"
            self.quantity = String(pair.event.quantity)
            
            if let discount = pair.discount?.discount {
                self.discount = "\(discount)"
                self.discountOn = true
                self.isDiscountValid = self.discount.count > 0
            }
            
            if let discountQuantity = pair.discount?.quantity {
                self.discountQuantity = "\(discountQuantity)"
                self.isDiscountQuantityValid  = self.discountQuantity.count > 0
            }
            
            isNameValid = self.name.count > 0
            isPriceValid = self.place.count > 0
            isPriceValid = self.price.count > 0
            isQuantityValid = self.quantity.count > 0
            
        }
        setUpValidation()
    }
    
    
    private func setUpValidation() {
        $name
            .receive(on: RunLoop.main)
            .map { name in
                return name.count > 0
            }
            .assign(to: \.isNameValid, on: self)
            .store(in: &cancellableSet)
        
        $place
            .receive(on: RunLoop.main)
            .map { place in
                return place.count > 0
            }
            .assign(to: \.isPlaceValid, on: self)
            .store(in: &cancellableSet)
        
        $price
            .receive(on: RunLoop.main)
            .map { price in
                return price.count > 0 && Int(price) != nil
            }
            .assign(to: \.isPriceValid, on: self)
            .store(in: &cancellableSet)
        
        $quantity
            .receive(on: RunLoop.main)
            .map { quantity in
                return quantity.count > 0 && Int(quantity) != nil
            }
            .assign(to: \.isQuantityValid, on: self)
            .store(in: &cancellableSet)
        
        $discountQuantity
            .receive(on: RunLoop.main)
            .map { discountQuantityString in
                if discountQuantityString.count == 0 { return false }
                if let discQuantity = Int(discountQuantityString) {
                    let totalQuantity = Int(self.quantity) ?? 0
                    return discQuantity <= totalQuantity
                }
                return false
            }
            .assign(to: \.isDiscountQuantityValid, on: self)
            .store(in: &cancellableSet)
        
        $discount.receive(on: RunLoop.main)
            .map { discount in
                return discount.count > 0 && Int(discount) != nil && Int(discount)! < 100
            }
            .assign(to: \.isDiscountValid, on: self)
            .store(in: &cancellableSet)
    }
    
    private func setEventData(event: EventEntity) {
        event.name = self.name
        event.eventDescription = self.eventDescription
        event.place = self.place
        event.date = self.date
        event.price = FormatUtils.decimal(with: self.price)
        event.quantity = Int16(self.quantity) ?? 0
    }
    
    private func setDiscountData(discount: DiscountEntity) {
        discount.name = self.name
        discount.eventDescription = self.eventDescription
        discount.place = self.place
        discount.date = self.date
        discount.price = FormatUtils.decimal(with: self.price)
        discount.discount = FormatUtils.decimal(with: self.discount)
        discount.quantity = Int16(self.discountQuantity) ?? 0
    }
    
    func updateEntity(pair: EventDiscountPair) {
        setEventData(event: pair.event)
        
        if let discount = pair.discount {
            if self.discountOn {
                setDiscountData(discount: discount)
            } else {
                self.context.delete(discount)
            }
        } else if self.discountOn {
            let discountEntity = DiscountEntity(context: context)
            discountEntity.id = pair.event.id
            discountEntity.photo = "/images/Concert.jpg"
            setDiscountData(discount: discountEntity)
        }
        
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("EntityChanged"), object: nil)
    }
    
    func createEntity() {
        
        let eventEntity = EventEntity(context: context)
        let id = getLastSavedId() + 1
        eventEntity.id = id
        setEventData(event: eventEntity)
        eventEntity.photo = "/images/Concert.jpg"
        
        if self.discountOn {
            let discountEntity = DiscountEntity(context: context)
            discountEntity.id = id
            discountEntity.photo = "/images/Concert.jpg"
            setDiscountData(discount: discountEntity)
        }
        
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("EntityChanged"), object: nil)
    }
    
    private func getLastSavedId() -> Int64 {
        let eventRequest: NSFetchRequest<EventEntity>
        eventRequest = EventEntity.fetchRequest()
        
        eventRequest.sortDescriptors = [NSSortDescriptor(keyPath: \EventEntity.id, ascending: false)]
        eventRequest.fetchLimit = 1
        guard let results = try? context.fetch(eventRequest),
              let first = results.first else { return 0 }
        
        return first.id
        
    }
    
    func saveChanges() {
        if let pair = self.eventDiscountPair {
            updateEntity(pair: pair)
        } else {
            createEntity()
        }
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}
