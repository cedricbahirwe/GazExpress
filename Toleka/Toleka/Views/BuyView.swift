//
//  BuyView.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 23/06/2023.
//

import SwiftUI

struct BuyView: View {
    var body: some View {
        List {
            ForEach(0..<15) { i in
                HStack {
                    Image("gas-container")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)

                    VStack(alignment: .leading) {
                        Text("Gas bottles")
                            .textCase(.uppercase)
                        Text("12 $")
                        Text("Click to select yours")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.background)
                .cornerRadius(12)
                .shadow(radius: 0.2)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        .background(Color(.secondarySystemBackground))
        .scrollContentBackground(.hidden)
        .toolbar {
            NavigationLink(value: NavRoute.cart) {
                Image(systemName: "cart.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
        .navigationTitle("New Purchase")
    }
}

struct BuyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BuyView()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
