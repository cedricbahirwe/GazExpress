//
//  OrderViewModel.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 25/06/2023.
//

import Foundation

final class OrderViewModel: ObservableObject {
    @Published private(set) var order: Order = Order(itemName: "",
                                                     itemSubtitle: "",
                                                     price: 0,
                                                     quantity: 0,
                                                     totalQuantity: 0)
    
    func updateQuantity(_ quantity: Int) {
        order.quantity = quantity
    }
    
    
    @Published private(set) var products: [Product] = []
    
    
    init() {
        self.products = generateProducts()
    }
    
    func setOrderFor(_ product: Product) {
        self.order = Order(itemName: product.name,
                           itemSubtitle: product.subtitle,
                           price: product.price,
                           quantity: 1,
                           totalQuantity: product.available)
    }
    
    func addOrderToCart(_ order: Order) {
        
    }
    
    func orderNow(_ order: Order) {
        
    }
    
    func generateProducts() -> [Product] {
        var products: [Product] = []
        
        products.append(Product(id: UUID(), coverImage: "image1.jpg", name: "12kg Propane Cylinder", subtitle: "Suitable for cooking purposes", description: "This 12kg propane cylinder is perfect for home cooking.", price: 50, currency: .usd, weight: 12))
        products.append(Product(id: UUID(), coverImage: "image2.jpg", name: "15kg Butane Cylinder", subtitle: "Ideal for cooking and heating", description: "Get this 15kg butane cylinder for cooking and heating purposes.", price: 60, currency: .usd, weight: 15))
        products.append(Product(id: UUID(), coverImage: "image3.jpg", name: "5kg LPG Cylinder", subtitle: "Compact and convenient", description: "This 5kg LPG cylinder is compact and easy to handle.", price: 30, currency: .usd, weight: 5))
        products.append(Product(id: UUID(), coverImage: "image4.jpg", name: "10kg Propane Cylinder", subtitle: "Great for cooking and camping", description: "Use this 10kg propane cylinder for cooking or take it with you on camping trips.", price: 40, currency: .usd, weight: 10))
        products.append(Product(id: UUID(), coverImage: "image5.jpg", name: "20kg Butane Cylinder", subtitle: "Large capacity for extended use", description: "With a capacity of 20kg, this butane cylinder is suitable for extended use.", price: 80, currency: .usd, weight: 20))
        products.append(Product(id: UUID(), coverImage: "image6.jpg", name: "6kg LPG Cylinder", subtitle: "Convenient size for small households", description: "This 6kg LPG cylinder is perfect for small households and apartments.", price: 35, currency: .usd, weight: 6))
        products.append(Product(id: UUID(), coverImage: "image7.jpg", name: "18kg Propane Cylinder", subtitle: "Versatile and reliable", description: "The 18kg propane cylinder offers versatility and reliability for your cooking needs.", price: 70, currency: .usd, weight: 18))
        products.append(Product(id: UUID(), coverImage: "image8.jpg", name: "7kg Butane Cylinder", subtitle: "Suitable for outdoor grilling", description: "Use this 7kg butane cylinder for outdoor grilling and barbecues.", price: 45, currency: .usd, weight: 7))
        products.append(Product(id: UUID(), coverImage: "image9.jpg", name: "9kg LPG Cylinder", subtitle: "Perfect for residential cooking", description: "This 9kg LPG cylinder is designed specifically for residential cooking purposes.", price: 55, currency: .usd, weight: 9))
        
        return products
    }
}
