//
//  HistoryView.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 23/06/2023.
//

import SwiftUI

struct HistoryView: View {
    let historyVM: HistoryViewModel
    var body: some View {
        VStack {
            if historyVM.records.isEmpty {
                Text("You don't have any orders yet!")
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(historyVM.records) { item in
                        NavigationLink(value: NavRoute.checkout) {
                            HistoryRowView(item: item)
                        }
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbarBackground(Color.accentColor, for: .navigationBar, .tabBar)
        .background(Color(.secondarySystemBackground))
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationTitle("My Orders")
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(historyVM: HistoryViewModel())
    }
}

private struct HistoryRowView: View {
    let item: History
        
    var body: some View {
        HStack {
            
            Circle()
                .fill(Material.ultraThinMaterial)
                .frame(width: 50, height: 50)
                .overlay {
                    Text("#\(item.id)")
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .padding(8)
                        .minimumScaleFactor(0.8)
                }
                .colorInvert()
            
            VStack(alignment: .leading, spacing: 6) {
                Text(item.cart.total)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(item.date.formatted(date: .abbreviated, time: .shortened) )
                    .fontDesign(.rounded)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
                    
               
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(item.status.rawValue.capitalized)
                .font(.caption)
                .fontDesign(.rounded)
                .fontWeight(.medium)
                .padding(8)
                .background(backgroundColor)
                .foregroundStyle(.thickMaterial)
                .clipShape(Capsule())
            
        }
        .padding(14)
        .background(.background)
        .cornerRadius(12)
        .shadow(radius: 0.2)
    }
    
    private var backgroundColor: Color {
        switch item.status {
        case .completed: return Color.accentColor
        case .unfinished: return .red
        case .pending: return .blue
        }
    }
}
