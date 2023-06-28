//
//  Location.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 28/06/2023.
//

import Foundation

struct Location: Codifiable, Hashable {
    var id: String { name }
    let name: String
    
    static let empty = Location(name: "")
    static let examples = ["Town", "Himbi", "ULPGL", "Kyeshero", "Virunga"].map(Location.init)
}
