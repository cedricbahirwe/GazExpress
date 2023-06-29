//
//  CheckoutView.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 26/06/2023.
//

import SwiftUI

typealias OrderCompletion = (location: Location, address: String, phone: String)
struct CheckoutView: View {
    private let cart: Cart
    private let locations: [Location]
    private let onCancelOrder: () -> Void
    private let onPayWithMomo: (OrderCompletion) -> Void
    
    @State private var orderLocation: Location
    @State private var orderAddress: String
    @State private var phoneNumber: String
    
    @State private var showCancelSheet = false
    @State private var showCompletionAlert = false
    
    init(cart: Cart,
         locations: [Location],
         onCancelOrder: @escaping () -> Void,
         onPayWithMomo: @escaping (OrderCompletion) -> Void) {
        self.cart = cart
        self.locations = locations
        self.onCancelOrder = onCancelOrder
        self.onPayWithMomo = onPayWithMomo
        self._orderLocation = State(wrappedValue: cart.location ?? locations.first ?? .empty)
        self._orderAddress = State(wrappedValue: cart.address ?? "")
        self._phoneNumber = State(wrappedValue: cart.phone ?? "")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Total Amount: \(cart.total)")
                .font(.title3)
                .fontDesign(.rounded)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.regularMaterial)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Items:")
                        .font(.headline)
                        .fontDesign(.rounded)
                    
                    
                    ForEach(cart.orders, content: CheckoutRowView.init)
                    
                    TitledFieldView(title: "Number To Pay", text: $phoneNumber)
                        .keyboardType(.phonePad)
                    
                    VStack(spacing: 4) {
                        
                        
                        HStack {
                            Text("Location")
                            Spacer()
                            Picker("Location", selection: $orderLocation) {
                                ForEach(locations) {
                                    Text($0.name)
                                        .tag($0)
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(.menu)
                        }
                        
                        Divider()
                            .frame(height: 1)
                            .overlay(Color.accentColor)
                    }
                    
                    TitledFieldView(title: "Exact Home Address", text: $orderAddress)
                    
                    HStack {
                        LargeButton("Cancel Order", tint: .red, foreground: .white) {
                            showCancelSheet.toggle()
                        }
                        
                        LargeButton("Pay with Momo", action: {
                            showCompletionAlert = true
                        })
                        .padding(.vertical)
                    }
                }
                .padding(.horizontal)
                
            }
            
        }
        .background(Color(.secondarySystemBackground))
        .navigationTitle("Order - #\(cart.id)")
        .alert(
            "Congratulations, Order Placed!",
            isPresented: $showCompletionAlert) {
                Button("OK", action: {
                    onPayWithMomo((orderLocation, orderAddress, phoneNumber))
                })
            }
        .confirmationDialog("Cancel Order",
                            isPresented: $showCancelSheet,
                            titleVisibility: .visible) {
            Button("No, Don't Cancel", role: .cancel) { }
            Button("Yes, Cancel", role: .destructive, action: onCancelOrder)
        } message: {
            Text("Do you want to cancel this order?")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CheckoutView(cart: .example,
                         locations: Location.examples,
                         onCancelOrder: {},
                         onPayWithMomo: { _ in })
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct CheckoutRowView: View {
    let order: Order
    
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
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background)
        .cornerRadius(12)
        .shadow(radius: 0.2)
    }
}
