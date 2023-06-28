//
//  OrderViewModel.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 25/06/2023.
//

import Foundation

final class OrderViewModel: ObservableObject {
    @Published private(set) var order: Order = Order.emptyOrder
    @Published private(set) var cart: Cart = Cart.emptyCart
    @Published private(set) var products: [Product] = []
    
    init() {
        self.products = generateProducts()
    }
    
    func setOrderFor(_ product: Product) {
        if let order = cart.getOrderFor(product) {
            self.order = order
        } else {
            self.order = Order(id: product.id, product: product, quantity: 1)
        }
    }
    
    func cartContains(_ product: Product) -> Bool {
        cart.getOrderFor(product) != nil
    }
    
    func addOrderToCart(_ order: Order) {
        cart.addOrder(order)
    }
    
    func removeOrderFromCart(_ order: Order) {
        cart.removeOrder(order)
    }
    
    func clearCart() {
        cart.clear()
    }
    
    func checkoutOrder(_ orderCompletion: OrderCompletion) {
        cart.address = orderCompletion.address
        cart.phone = orderCompletion.phone
        cart.location = orderCompletion.location
        
        let history = History(cart: cart, date: .now, status: Bool.random() ? .completed : Bool.random() ? .pending : .unfinished)
        
        saveCartToHistory(history)
        clearCart()
    }
    
    func saveCartToHistory(_ newItem: History) {
        let defaults = UserDefaults.standard
        
        do {
            if let savedHistoryData = defaults.data(forKey: UserDefaultsKeys.history.rawValue),
               !savedHistoryData.isEmpty {
                var newHistory = try JSONDecoder().decode([History].self, from: savedHistoryData)
                newHistory.append(newItem)
                
                try saveItems(newHistory)
                
                print("Next saved")
                
            } else {
                try saveItems([newItem])
                print("First saved")
            }
        } catch {
            print(error.localizedDescription)
        }
        
        func saveItems(_ history: [History]) throws {
            let historyData = try JSONEncoder().encode(history)
            defaults.set(historyData, forKey: UserDefaultsKeys.history.rawValue)
        }
        
    }
    
    func getCartCount() -> Int {
        cart.orders.count
    }
    
}
extension OrderViewModel {
    func generateProducts() -> [Product] {
        var products: [Product] = []
        
        products.append(Product(id: Int.random(in: 1...100), coverImage: "image1.jpg", name: "12kg Propane Cylinder", subtitle: "Suitable for cooking purposes", description: "This 12kg propane cylinder is perfect for home cooking.", price: 50, currency: .usd, weight: 12, available: 10))
        products.append(Product(id: Int.random(in: 1...100), coverImage: "image2.jpg", name: "15kg Butane Cylinder", subtitle: "Ideal for cooking and heating", description: "Get this 15kg butane cylinder for cooking and heating purposes.", price: 60, currency: .usd, weight: 15, available: 10))
        products.append(Product(id: Int.random(in: 1...100), coverImage: "image3.jpg", name: "5kg LPG Cylinder", subtitle: "Compact and convenient", description: "This 5kg LPG cylinder is compact and easy to handle.", price: 30, currency: .usd, weight: 5, available: 10))
        products.append(Product(id: Int.random(in: 1...100), coverImage: "image4.jpg", name: "10kg Propane Cylinder", subtitle: "Great for cooking and camping", description: "Use this 10kg propane cylinder for cooking or take it with you on camping trips.", price: 40, currency: .usd, weight: 10, available: 1))
        products.append(Product(id: Int.random(in: 1...100), coverImage: "image5.jpg", name: "20kg Butane Cylinder", subtitle: "Large capacity for extended use", description: "With a capacity of 20kg, this butane cylinder is suitable for extended use.", price: 80, currency: .usd, weight: 20, available: 10))
        products.append(Product(id: Int.random(in: 1...100), coverImage: "image6.jpg", name: "6kg LPG Cylinder", subtitle: "Convenient size for small households", description: "This 6kg LPG cylinder is perfect for small households and apartments.", price: 35, currency: .usd, weight: 6, available: 3))
        products.append(Product(id: Int.random(in: 1...100), coverImage: "image7.jpg", name: "18kg Propane Cylinder", subtitle: "Versatile and reliable", description: "The 18kg propane cylinder offers versatility and reliability for your cooking needs.", price: 70, currency: .usd, weight: 18, available: 10))
        products.append(Product(id: Int.random(in: 1...100), coverImage: "image8.jpg", name: "7kg Butane Cylinder", subtitle: "Suitable for outdoor grilling", description: "Use this 7kg butane cylinder for outdoor grilling and barbecues.", price: 45, currency: .usd, weight: 7, available: 10))
        products.append(Product(id: Int.random(in: 1...100), coverImage: "image9.jpg", name: "9kg LPG Cylinder", subtitle: "Perfect for residential cooking", description: "This 9kg LPG cylinder is designed specifically for residential cooking purposes.", price: 55, currency: .usd, weight: 9, available: 10))
        
        return products
    }
    
    
    func getLocations() -> [Location] {
        Location.examples
    }
}


enum UserDefaultsKeys: String {
    case history
}

enum UserDefaultsStore {
    
}
