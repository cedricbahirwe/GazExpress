//
//  CartPreview.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 23/06/2023.
//

import SwiftUI

struct CartPreview: View {
    @State private var entry = ""
    var body: some View {
        VStack(alignment: .leading) {
            Text("Gas bottles")
                .font(.title2)
                .fontDesign(.rounded)
                .textCase(.uppercase)
            
            Text("Click to select yours")
                .font(.headline)
                .foregroundColor(.secondary)
            
            TitledFieldView(title: "Quantity", text: $entry)
            
            Text("1 * 15$ = 30$")
                .fontDesign(.rounded)
            
            HStack {
                LargeButton("Order Now", tint: .primary) { }
                
                LargeButton("Add To Cart") { }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CartPreview_Previews: PreviewProvider {
    static var previews: some View {
        CartPreview()
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
                    if !showTitle { titleView }
                }
                .overlay(alignment: .bottom) {
                    Color.accentColor.frame(height: 1)
                }
                .onChange(of: isFocused) { newValue in
                    withAnimation {
                        showTitle = newValue
                    }
                }
        }
    }
}
