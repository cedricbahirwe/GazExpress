//
//  Product.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 25/06/2023.
//

import Foundation

struct Product: Identifiable {
    let id: UUID
    let coverImage: String
    let name: String
    let subtitle: String
    let description: String?
    
    let price: Double
    let currency: Currency
    let weight: Double
    let available: Int = 10
}

enum Currency: String {
    case cdf, usd
    
    var symbol: String {
        switch self {
        case .cdf: return "CDF"
        case .usd: return "$"
        }
    }
}
