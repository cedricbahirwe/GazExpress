//
//  HomeView.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 22/06/2023.
//

import SwiftUI

struct HomeView: View {
    @Binding var navPath: NavigationPath
    @ObservedObject var orderVM: OrderViewModel
    
    private let tariffs = [
        GasTariff(type: "6Kg", price: 15),
        GasTariff(type: "12Kg", price: 30),
        GasTariff(type: "15Kg", price: 36)
    ]
    
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var goToProfile = false
    @State private var goToCart = false
    
    @State private var presentCallActionSheet = false
    
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
                    
                    CartButton(count: orderVM.getCartCount())
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
                        
                        NavigationLink(value: NavRoute.buyNew) {
                            ItemSelectionView(icon: Image("gas-container"), title: "Buy New")
                        }
                        
                        NavigationLink(value: NavRoute.refill) {
                            ItemSelectionView(icon: Image("gas-refill"), title: "Refill Gas")
                        }
                    }
                    
                    GridRow {
                        ItemSelectionView(icon: Image(systemName: "phone.and.waveform"), title: "Contact Us ") {
                            presentCallActionSheet.toggle()
                        }
                        .confirmationDialog(
                            "Call Us",
                            isPresented: $presentCallActionSheet,
                            titleVisibility: .hidden) {
                                Button("Call Us", action: openPhone)
                                Button("WhatsApp", action: openWhatsApp)
                            }
                        
                        NavigationLink(value: NavRoute.history) {
                             ItemSelectionView(icon:
                                                Image(systemName: "clock.arrow.2.circlepath"), title: "Historic")
                        }
                    }
                }
                
                Spacer()
            }
            .padding(30)
        }
        .toolbar(.hidden)
    }
    
    private func openWhatsApp() {
        if let whatsappURL = URL(string: "https://wa.me/250782628511?text=I%20would%20like%20to%20order%20one%20bottle%20of%20cooking%20gas") {
            if UIApplication.shared.canOpenURL(whatsappURL) {
                UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
            } else {
                // WhatsApp is not installed on the device
                // Handle this case or prompt the user to install WhatsApp
            }
        }
    }
    
    private func openPhone() {
        if let phoneURL = URL(string: "tel://250782628511") {
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL)
            } else {
                // Phone is not installed on the device
                // Handle this case or prompt the user to install WhatsApp
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView(navPath: .constant(.init()),
                     orderVM: OrderViewModel())
        }
    }
}

struct ItemSelectionView: View {
    let icon: Image
    let title: String
    var action: (() -> Void)? = nil
    
    private var contentView: some View {
        VStack(spacing: 20) {
            icon
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 80)
                .foregroundColor(.accentColor)
            
            Text(title)
                .font(.headline)
                .fontDesign(.rounded)
                .foregroundColor(.primary)
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
    }
    
    var body: some View {
        if let action {
            contentView
                .contentShape(Rectangle())
                .onTapGesture(perform: action)
        } else {
            contentView
        }
    }
}
