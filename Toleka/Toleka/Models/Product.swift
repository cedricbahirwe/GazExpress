//
//  Product.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 25/06/2023.
//

import Foundation

struct Product: Codifiable, Equatable {
    let id: Int
    let coverImage: String
    let name: String
    let subtitle: String
    var description: String?
    
    let price: Double
    let currency: Currency
    let weight: Double?
    let available: Int
    
    
    static let example = Product(id: Int.random(in: 1...100), coverImage: "image1.jpg", name: "12kg Propane Cylinder", subtitle: "Suitable for cooking purposes", description: "This 12kg propane cylinder is perfect for home cooking.", price: 50, currency: .usd, weight: 12, available: 10)

}

enum Currency: String, Codable {
    case cdf, usd
    
    var code: String {
        rawValue.uppercased()
    }
}
