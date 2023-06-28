//
//  HistoryViewModel.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 28/06/2023.
//

import Foundation

final class HistoryViewModel : ObservableObject {
    @Published private(set) var records: [History] = []
    // look in local database
    
    
}


struct History: Identifiable {
    var id: Int { cart.id }
    
    let cart: Order
    
    let status: OrderStatus
    
    enum OrderStatus {
        case pending
        case completed
        case unfinished
    }
}
