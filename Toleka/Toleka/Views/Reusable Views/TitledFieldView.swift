//
//  TitledFieldView.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 26/06/2023.
//

import SwiftUI

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
