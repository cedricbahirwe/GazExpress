//
//  CartPreview.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 23/06/2023.
//

import SwiftUI

struct Order {
    let itemName: String
    let itemSubtitle: String
    let price: Double
    
    var quantity: Int
    let totalQuantity: Int
    
    var totalPrice: Double {
        Double(quantity) * price
    }
    
    static let example = Order(itemName: "Pipe Connector(3)", itemSubtitle: "Two different Cylinders pipe Connections", price: 15, quantity: 1, totalQuantity: 10)
}
struct CartPreview: View {
    private let item: Order
    
    @State private var quantity: Int
    
    var onOrderNowClicked: (Order) -> Void
    var onAddToCartClicked: (Order) -> Void = { _ in }
    var onQuantityChanged: (Int) -> Void = { _ in }
    
    init(item: Order,
         onOrderNowClicked: @escaping (Order) -> Void = { _ in },
         onAddToCartClicked: @escaping (Order) -> Void = { _ in },
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
                LargeButton("Order Now", tint: .primary, foreground: Color(.systemBackground)) { }
                
                LargeButton("Add To Cart") { }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CartPreview_Previews: PreviewProvider {
    static var previews: some View {
        CartPreview(item: .example)
            .previewLayout(.sizeThatFits)
    }
}


struct TitledFieldView: View {
    let title: LocalizedStringKey
    @Binding var text: String
    
    @Namespace private var namespace
    @FocusState private var isFocused
    @State private var showTitle = false
    
    private var titleView: some View {
        Text(title)
            .foregroundColor(.secondary)
            .matchedGeometryEffect(id: "title", in: namespace)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            if showTitle {
                titleView
            }
               
            TextField("", text: $text)
                .focused($isFocused)
                .padding(.vertical, 10)
                .background(alignment: .leading) {
                    if text.isEmpty && !showTitle { titleView }
                }
                .overlay(alignment: .bottom) {
                    Color.accentColor.frame(height: 1)
                }
                .onChange(of: text) { newValue in
                    withAnimation {
                        showTitle = !newValue.isEmpty
                    }
                }
        }
    }
}
