//
//  Cart.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 26/06/2023.
//

import Foundation

struct Cart {
    var orders: [Order] = []
     
    var totalPrice: Double {
        orders.map(\.totalPrice).reduce(0, +)
    }
    
    static let emptyCart = Cart()
    
    static let example = Cart(orders: [.example])
    
}
