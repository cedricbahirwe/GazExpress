//
//  Array+Extensions.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 28/06/2023.
//

import Foundation

extension Array where Element: Equatable {
    func doesntContain(_ element: Element) -> Bool {
        !contains(element)

    }
}
