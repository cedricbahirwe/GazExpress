//
//  CartViewModel.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 26/06/2023.
//

import Foundation

final class CartViewModel: ObservableObject {
    
    @Published private(set) var cart: Cart = Cart.emptyCart

    
    
    
    
    func addOrder(_ order: Order) {
        let sss = ["", "", "asa"]
        sss.contains("as")
//        guard cart.orders.contains(where: <#T##(Order) throws -> Bool#>)
    }
    
    
}
