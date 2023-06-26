//
//  CartPreview.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 23/06/2023.
//

import SwiftUI

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
