//
//  BuyView.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 23/06/2023.
//

import SwiftUI

struct BuyView: View {
    @Binding var navPath: NavigationPath

    @State private var showCartPreview = false
    @ObservedObject var orderVM: OrderViewModel
    var body: some View {
        List {
            ForEach(orderVM.products) { product in
                ProductRowView(product: product)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .onTapGesture {
                        withAnimation {
                            showCartPreview = true
                            orderVM.setOrderFor(product)
                        }
                    }
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
        .sheet(isPresented: $showCartPreview) {
            CartPreview(item: orderVM.order,
                        onOrderNowClicked: {
                navPath.append(NavRoute.checkout)
                
            },
                        onAddToCartClicked: orderVM.addOrderToCart,
                        onQuantityChanged: orderVM.updateQuantity)
            .presentationDetents([.height(250)])
            .presentationBackground(.ultraThickMaterial)
            .presentationCornerRadius(20)
        }
    }
}

struct BuyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BuyView(navPath: .constant(.init()), orderVM: OrderViewModel())
                .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct ProductRowView: View {
    let product: Product
    var isPreview: Bool = false
    
    var body: some View {
        HStack {
            Image("gas-container")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text(product.name)
                    .textCase(.uppercase)
                Text(product.price, format: .currency(code: product.currency.code))
                
                Text(product.subtitle)
                    .font(.caption)
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
