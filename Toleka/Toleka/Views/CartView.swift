//
//  CartView.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 22/06/2023.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var cartVM: CartViewModel
    var isCartEmpty = false
    
    var body: some View {
        Group {
            if isCartEmpty {
                Text("Your cart is empty.\nStart by adding items to the cart!")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .padding(30)
            } else {
                VStack(alignment: .leading, spacing: 20) {
//
//                    HStack {
//                        Text("Total: \(cartVM.cart.totalPrice)")
//                            .font(.title2)
//                            .fontWeight(.medium)
//                            .fontDesign(.rounded)
//
//                        Spacer()
//
//                        LargeButton("Order Now") {
//
//                        }
//                        .frame(maxWidth: 120)
//                    }
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(.ultraThickMaterial)
//                    .cornerRadius(12)
//                    .shadow(radius: 1)
//
//                    ForEach(cartVM.cart.orders) { order in
//                        CartRowView(order: order) {
//                            cartVM.deleteOrder(order)
//                        }
//                    }
//
//
//                    CartRowView(order: .example) {
//
//                    }
//
//
                    Spacer()
                }
                .padding()
            }
        }
        .toolbarBackground(Color.accentColor, for: .navigationBar, .tabBar)
        .background(Color(.secondarySystemBackground))
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationTitle("My Cart")
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CartView(cartVM: CartViewModel())
                .navigationBarTitleDisplayMode(.inline)
//                .preferredColorScheme(.dark)
        }
    }
}


private struct CartRowView: View {
    let order: Order
    
    let onDeleteClicked: () -> Void
    
    var body: some View {
        HStack {
            RowImage("gas-container")
            
            VStack(alignment: .leading, spacing: 6) {
                Text(order.itemName)
                    .textCase(.uppercase)
                
                Text("\(String(format: "%.2f \(order.currencyCode)", order.price, order.totalPrice)) X \(order.quantity)")
                    .fontDesign(.rounded)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    
               
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "trash.fill")
                .imageScale(.large)
                .foregroundColor(.red)
                .padding()
                .contentShape(Rectangle())
                .onTapGesture(perform: onDeleteClicked)
        }
        .padding()
        .background(.background)
        .cornerRadius(12)
        .shadow(radius: 0.2)
    }
}
