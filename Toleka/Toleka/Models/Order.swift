//
//  Order.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 26/06/2023.
//

import Foundation

struct Order: Identifiable, Equatable {
    let id: Int
    let product: Product
    var quantity: Int
}

extension Order {
    var itemName: String { product.name }
    var itemSubtitle: String { product.subtitle}
    var price: Double { product.price }
    var totalQuantity: Int { product.available }
    
    var totalPrice: Double { Double(quantity) * price }
    
    var unitPrice: String {
        price.asCurrency(product.currency)
    }
    var total: String {
        totalPrice.asCurrency(product.currency)
    }
    
    static let example = Order(id: (100...100).randomElement()!,
                               product: .example,
                               quantity: 1)
    
    static let emptyOrder = Order(id: 0,
                                  product: .init(id: .init(), coverImage: "", name: "", subtitle: "", description: "", price: 0, currency: .usd, weight: 0),
                                  quantity: 0)
}
