//
//  CartPreview.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 23/06/2023.
//

import SwiftUI

struct CartPreview: View {
    @Environment(\.dismiss) private var dismiss
    @State var order: Order
        
    var onOrderNowClicked: (Order) -> Void
    var onAddToCartClicked: (Order) -> Void
    
    init(order: Order,
         onOrderNowClicked: @escaping (Order) -> Void,
         onAddToCartClicked: @escaping (Order) -> Void) {
        self._order = State(wrappedValue: order)
        self.onOrderNowClicked = onOrderNowClicked
        self.onAddToCartClicked = onAddToCartClicked
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(order.itemName)
                .font(.title2)
                .fontDesign(.rounded)
                .textCase(.uppercase)
            
            Text(order.itemSubtitle)
                .font(.headline)
                .foregroundColor(.secondary)
            
            Stepper("Enter Quantity: ", value: $order.quantity, in: 1...order.totalQuantity)
            
            Text("Total: \(order.quantity) * \(String(format: "%.2f$ = %.2f", order.price, order.totalPrice))$")
                .fontDesign(.rounded)
                .fontWeight(.bold)
            
            HStack {
                LargeButton("Order Now", tint: .primary, foreground: Color(.systemBackground), action: {
                    dismiss()
                    onOrderNowClicked(order)
                })
                
                LargeButton("Add To Cart", action: {
                    dismiss()
                    onAddToCartClicked(order)
                })
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CartPreview_Previews: PreviewProvider {
    static var previews: some View {
        CartPreview(order: .example,
                    onOrderNowClicked: { _ in },
                    onAddToCartClicked: { _ in })
            .previewLayout(.sizeThatFits)
    }
}
