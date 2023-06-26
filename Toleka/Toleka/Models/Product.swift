//
//  Product.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 25/06/2023.
//

import Foundation

struct Product: Identifiable, Equatable {
    let id: UUID
    let coverImage: String
    let name: String
    let subtitle: String
    let description: String?
    
    let price: Double
    let currency: Currency
    let weight: Double
    let available: Int = 10
    
    
    static let example = Product(id: UUID(), coverImage: "image1.jpg", name: "12kg Propane Cylinder", subtitle: "Suitable for cooking purposes", description: "This 12kg propane cylinder is perfect for home cooking.", price: 50, currency: .usd, weight: 12)

}

enum Currency: String {
    case cdf, usd
    
    var code: String {
        rawValue.uppercased()
    }
}
