//
//  Double+Extensions.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 28/06/2023.
//

import Foundation

extension Equatable {
    func notIn<T: Equatable>(_ elements: [T]) -> Bool {
        elements.doesntContain(self as! T)
    }
}

