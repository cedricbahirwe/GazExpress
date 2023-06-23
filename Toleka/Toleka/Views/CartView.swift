//
//  CartView.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 22/06/2023.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        VStack {
            Text("Your cart is empty.\nStart by adding items to the cart!")
                .multilineTextAlignment(.center)
                .font(.headline)
                .padding(30)
        }
        .padding()
        .toolbarBackground(Color.accentColor, for: .navigationBar, .tabBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationTitle("My Cart")
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CartView()
        }
    }
}
