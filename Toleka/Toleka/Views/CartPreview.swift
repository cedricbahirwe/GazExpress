//
//  CartPreview.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 23/06/2023.
//

import SwiftUI

struct Order: Identifiable {
    
    let id: Int
    let product: Product
    var quantity: Int
    
    var itemName: String { product.name }
    var itemSubtitle: String { product.subtitle}
    var price: Double { product.price }
    var totalQuantity: Int { product.available }
    var currencyCode: String { product.currency.code }
    
    var totalPrice: Double { Double(quantity) * price }
    
    static let example = Order(id: (100...100).randomElement()!,
                               product: .example,
                               quantity: 1)
    
    static let emptyOrder = Order(id: 0,
                                  product: .init(id: .init(), coverImage: "", name: "", subtitle: "", description: "", price: 0, currency: .usd, weight: 0),
                                  quantity: 0)
}
struct CartPreview: View {
    @Environment(\.dismiss) private var dismiss
    private let item: Order
    
    @State private var quantity: Int
    
    var onOrderNowClicked: () -> Void
    var onAddToCartClicked: () -> Void
    var onQuantityChanged: (Int) -> Void = { _ in }
    
    init(item: Order,
         onOrderNowClicked: @escaping () -> Void,
         onAddToCartClicked: @escaping () -> Void,
         onQuantityChanged: @escaping (Int) -> Void = { _ in }) {
        self.item = item
        self._quantity = State(wrappedValue: item.quantity)
        self.onOrderNowClicked = onOrderNowClicked
        self.onAddToCartClicked = onAddToCartClicked
        self.onQuantityChanged = onQuantityChanged
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.itemName)
                .font(.title2)
                .fontDesign(.rounded)
                .textCase(.uppercase)
            
            Text(item.itemSubtitle)
                .font(.headline)
                .foregroundColor(.secondary)
            
            Stepper("Enter Quantity: ", value: $quantity, in: 1...item.totalQuantity)
                .onChange(of: quantity, perform: onQuantityChanged)
            
            Text("Total: \(item.quantity) * \(String(format: "%.2f$ = %.2f", item.price, item.totalPrice))$")
                .fontDesign(.rounded)
                .fontWeight(.bold)
            
            HStack {
                LargeButton("Order Now", tint: .primary, foreground: Color(.systemBackground), action: {
                    dismiss()
                    onOrderNowClicked()
                })
                
                LargeButton("Add To Cart", action: {
                    dismiss()
                    onAddToCartClicked()
                })
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CartPreview_Previews: PreviewProvider {
    static var previews: some View {
        CartPreview(item: .example, onOrderNowClicked: {}, onAddToCartClicked: {})  
            .previewLayout(.sizeThatFits)
    }
}
