//
//  CheckoutView.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 26/06/2023.
//

import SwiftUI

struct CheckoutView: View {
    let order: Order
    let locations: [Location]
    
    let onCancelOrder: () -> Void
    let onPayWithMomo: (_ location: Location, _ address: String) -> Void
    
    @State private var orderLocation = Location.empty
    @State private var orderAddress = ""
    @State private var showCancelSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Total Amount: \(String(format: "%0.2f", order.totalPrice)) \(order.currencyCode)")
                .font(.title3)
                .fontDesign(.rounded)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.regularMaterial)
            
            VStack(alignment: .leading) {
                Text("Items:")
                    .font(.headline)
                    .fontDesign(.rounded)
                
                CheckoutRowView(order: order)
                
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
                        onPayWithMomo(orderLocation, orderAddress)
                    })
                        .padding(.vertical)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
        }
        .background(Color(.secondarySystemBackground))
        .navigationTitle("Order - #\(order.id)")
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
            CheckoutView(order: .example,
                         locations: Location.examples,
                         onCancelOrder: {},
                         onPayWithMomo: { _,_  in })
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CheckoutRowView: View {
    let order: Order
    
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
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background)
        .cornerRadius(12)
        .shadow(radius: 0.2)
    }
}

struct Location : Identifiable, Hashable {
    let id = UUID()
    let name: String
    
    static let empty = Location(name: "")
    static let examples = ["Town", "Himbi", "ULPGL", "Kyeshero", "Virunga"].map(Location.init)
}
