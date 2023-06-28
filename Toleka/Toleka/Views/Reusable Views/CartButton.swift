//
//  CartButton.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 28/06/2023.
//

import SwiftUI

struct CartButton: View {
    let count: Int
    var body: some View {
        NavigationLink(value: NavRoute.cart) {
            Image(systemName: "cart.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .overlay {
                    Text(String(count))
                        .font(.caption)
                        .frame(width: 20, height: 20)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                        .offset(x: 12, y: -12)
                }
        }
    }
}

struct CartButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CartButton(count: 10)
                .padding()
        }
        .previewLayout(.fixed(width: 80, height: 80))
    }
}
