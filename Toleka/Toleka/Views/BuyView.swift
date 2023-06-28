//
//  BuyView.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 23/06/2023.
//

import SwiftUI

struct BuyView: View {
    @Binding var navPath: NavigationPath
    @ObservedObject var orderVM: OrderViewModel

    @State private var showCartPreview = false
    
    var body: some View {
        List {
            ForEach(orderVM.products) { product in
                ProductRowView(
                    product: product,
                    isInCart: orderVM.cartContains(product))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .onTapGesture {
                        withAnimation {
                            orderVM.setOrderFor(product)
                            showCartPreview = true
                        }
                    }
            }
        }
        .listStyle(.plain)
        .background(Color(.secondarySystemBackground))
        .scrollContentBackground(.hidden)
        .toolbar {
            CartButton(count: orderVM.getCartCount())
        }
        .navigationTitle("New Purchase")
        .sheet(isPresented: $showCartPreview) {
            CartPreview(
                order: orderVM.order,
                onOrderNowClicked: { order in
                    orderVM.addOrderToCart(order)
                    navPath.append(NavRoute.checkout)
                }, onAddToCartClicked: orderVM.addOrderToCart)
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
    var isInCart: Bool = true
    var isPreview: Bool = false
    
    var body: some View {
        HStack {
            RowImage("gas-container")
            
            VStack(alignment: .leading) {
                Text(product.name)
                    .textCase(.uppercase)
                Text(product.price, format: .currency(code: product.currency.code))
                
                Text(product.subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .overlay(alignment: .leading, content: {
            Circle()
                .fill(Color.accentColor)
                .frame(width: 8, height: 8)
                .opacity(isInCart ? 1 : 0)
                .offset(x: -8)
        })
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background)
        .cornerRadius(12)
        .shadow(radius: 0.2)
    }
}
