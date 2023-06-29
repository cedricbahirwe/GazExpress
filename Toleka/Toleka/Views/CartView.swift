//
//  CartView.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 22/06/2023.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var orderVM: OrderViewModel
    var onOrderClicked: () -> Void
    
    var isCartEmpty: Bool {
        orderVM.cart.orders.isEmpty
    }
    
    var body: some View {
        Group {
            if isCartEmpty {
                Text("Your cart is empty.\nStart by adding items to the cart!")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .padding(30)
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Total: \(orderVM.cart.total)")
                            .font(.title2)
                            .fontWeight(.medium)
                            .fontDesign(.rounded)

                        Spacer()

                        LargeButton("Order Now", action: onOrderClicked)
                            .frame(maxWidth: 120)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.ultraThickMaterial)
                    .cornerRadius(12)
                    .shadow(radius: 1)

                    ScrollView(showsIndicators: false) {
                        ForEach(orderVM.cart.orders) { order in
                            CartRowView(
                                order: order,
                                onDeleteClicked: {
                                    withAnimation {
                                        orderVM.removeOrderFromCart(order)
                                    }
                                })
                        }
                    }
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbarBackground(Color.accentColor, for: .navigationBar, .tabBar)
        .background(Color(.secondarySystemBackground))
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationTitle("My Cart")
    }
}

struct CartView_Previews: PreviewProvider {
    static let vm = OrderViewModel()
    static var previews: some View {
        NavigationView {
            CartView(orderVM: vm, onOrderClicked: {})
                .navigationBarTitleDisplayMode(.inline)
                .onAppear() {
                    vm.addOrderToCart(.example)
                }
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
                
                Text("\(order.unitPrice) X \(order.quantity)")
                    .fontDesign(.rounded)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    
               
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "trash.fill")
                .imageScale(.large)
                .foregroundColor(.red)
                .padding(5)
                .contentShape(Rectangle())
                .onTapGesture(perform: onDeleteClicked)
        }
        .padding(14)
        .background(.background)
        .cornerRadius(12)
        .shadow(radius: 0.2)
    }
}
