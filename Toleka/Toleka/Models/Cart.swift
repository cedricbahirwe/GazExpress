//
//  Cart.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 26/06/2023.
//

import Foundation

struct Cart {
    private(set) var orders: [Order] = []
     
    var totalPrice: Double {
        orders.map(\.totalPrice).reduce(0, +)
    }

    mutating func addOrder(_ newOrder: Order) {
        guard orders.contains(where: { $0.id == newOrder.id }) else { return }
        orders.append(newOrder)
    }
    
    mutating func removeOrder(_ order: Order) {
        if let index = orders.firstIndex(of: order) {
            orders.remove(at: index)
        }
    }
    
    func getOrderFor(_ product: Product) -> Order? {
        orders.first { $0.product == product }
    }
}

extension Cart {
    static let emptyCart = Cart()
    
    static let example = Cart(orders: [.example])
}
