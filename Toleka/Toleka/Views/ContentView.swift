//
//  ContentView.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 21/06/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject private var orderVM = OrderViewModel()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var navPath = NavigationPath()
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some View {
        NavigationStack(path: $navPath) {
            AuthenticationView(navPath: $navPath)
                .onChange(of: isLoggedIn) { newValue in
                    if newValue {
                        navPath.removeLast(navPath.count)
                    }
                }
                .onAppear() {
                    if isLoggedIn {
//                        navPath.append(NavRoute.home)
                    }
                    
                }
                .navigationDestination(for: NavRoute.self) { newRoute in
                    switch newRoute {
                    case .home:
                        HomeView(navPath: $navPath, orderVM: orderVM)
                    case let .profile(profile):
                        ProfileView(profile: profile, navPath: $navPath)
                    case .cart:
                        CartView(orderVM: orderVM) {
                            navPath.append(NavRoute.checkout)
                        }
                    case .history:
                        HistoryView()
                    case .buyNew:
                        BuyView(navPath: $navPath, orderVM: orderVM)
                    case .checkout:
                        CheckoutView(order: orderVM.order,
                                     locations: orderVM.getLocations()) {
                            navPath.removeLast()
                        } onPayWithMomo: { location, address in
                            orderVM.checkoutOrder()
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

enum NavRoute: Hashable {
    case home
    case profile(ProfileData)
    case cart
    case history
    case buyNew
    case checkout
}
