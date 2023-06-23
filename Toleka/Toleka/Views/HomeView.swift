//
//  HomeView.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 22/06/2023.
//

import SwiftUI

struct HomeView: View {
    private let tariffs = [
        GasTariff(type: "6Kg", price: 15),
        GasTariff(type: "12Kg", price: 30),
        GasTariff(type: "15Kg", price: 36)
    ]
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var goToProfile = false
    @State private var goToCart = false
    
    @Binding var navPath: NavigationPath
    
    var body: some View {
        VStack {
            VStack(spacing: 25) {
                HStack {
                    
                    NavigationLink(value: NavRoute.profile(.init())) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    
                    Spacer()
                    
                    Text("Toleka")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    NavigationLink(value: NavRoute.cart(.init())) {
                        Image(systemName: "cart.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
                .foregroundColor(.white)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Gas Tariff")
                        .font(.headline)
                        .foregroundStyle(Color.accentColor)
                        .frame(maxWidth: .infinity)
                    
                    
                    ForEach(tariffs, id: \.self) { tariff in
                        Text("❖ \(tariff.type) = \(Int(tariff.price))$")
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
                .cornerRadius(12)
                
            }
            .padding([.horizontal, .bottom], 30)
            .background(Color.accentColor)
            
            VStack {
                Grid(horizontalSpacing: 30, verticalSpacing: 30) {
                    GridRow {
                        ItemSelectionView(icon: Image("gas-container"), title: "Buy New") {
                            
                        }
                        
                        ItemSelectionView(icon: Image("gas-refill"), title: "Refill Gas") {
                            
                        }
                    }
                    
                    GridRow {
                        ItemSelectionView(icon: Image(systemName: "phone.and.waveform"), title: "Call Us ") {
                            
                        }
                        
                        ItemSelectionView(icon:
                                            Image(systemName: "clock.arrow.2.circlepath"), title: "Historic") {
                            
                        }
                    }
                }
                
                Spacer()
                
                Button("Logout", role: .destructive) {
                    isLoggedIn = false
//                    navPath.removeLast(navPath.count)
                }                
            }
            .padding(30)
        }
        .toolbar(.hidden)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView(navPath: .constant(.init()))
        }
    }
}

struct ItemSelectionView: View {
    let icon: Image
    let title: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            icon
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 80)
                .foregroundColor(.accentColor)
            
            Text(title)
                .font(.headline)
                .fontDesign(.rounded)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1, contentMode: .fit)
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Material.thickMaterial, lineWidth: 3)
        })
        .shadow(radius: 0.1)
        .contentShape(Rectangle())
        .onTapGesture(perform: action)
    }
}

enum NavRoute: Hashable {
    case home
    case profile(ProfileData)
    case cart(CartData)
}
