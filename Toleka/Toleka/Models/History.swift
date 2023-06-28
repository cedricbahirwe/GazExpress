//
//  History.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 28/06/2023.
//

import Foundation

struct History: Codifiable {
    var id: Int { cart.id }
    
    let cart: Cart
    
    let date: Date
    let status: OrderStatus
    
    enum OrderStatus: String, Codable {
        case pending
        case completed
        case unfinished
    }
}

extension History {
    static let examples =  [
        History(cart: .example, date: .now, status: .unfinished),
        History(cart: .example, date: .distantPast, status: .completed),
        History(cart: .example, date: .distantFuture, status: .pending),
    ]
}
