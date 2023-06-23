//
//  HistoryView.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 23/06/2023.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        VStack {
            Text("You don't have any orders yet!")
        }
        .padding()
        .toolbarBackground(Color.accentColor, for: .navigationBar, .tabBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationTitle("My Orders")
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
