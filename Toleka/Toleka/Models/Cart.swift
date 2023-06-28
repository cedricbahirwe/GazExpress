//
//  Cart.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 26/06/2023.
//

import Foundation

struct Cart: Codifiable {
    let id: Int
    private(set) var orders: [Order] = []
    
    var phone: String?
    
    var location: Location?
    
    var address: String?
     
    var totalPrice: Double {
        orders.map(\.totalPrice).reduce(0, +)
    }
    
    var total: String {
        totalPrice.asCurrency(orders.first?.product.currency ?? Currency.usd)
    }

    mutating func addOrder(_ newOrder: Order) {
        if let index = orders.firstIndex(where: { $0.id == newOrder.id }) {
            orders[index] = newOrder
        } else {
            orders.append(newOrder)
        }
    }
    
    mutating func removeOrder(_ order: Order) {
        if let index = orders.firstIndex(of: order) {
            orders.remove(at: index)
        }
    }
    
    func getOrderFor(_ product: Product) -> Order? {
        orders.first { $0.product == product }
    }
    
    mutating func clear() {
        orders = []
        phone = nil
        address = nil
        location = nil
    }
}

extension Cart {
    static let emptyCart = Cart(id: Int.random(in: 1...100))
    
    static let example = Cart(id: -1, orders: [.example])
}
