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
            
            if !isLoggedIn {
                AuthenticationView(navPath: $navPath)
            } else {
                HomeView(navPath: $navPath, orderVM: orderVM)
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
                            HistoryView(historyVM: orderVM.historyVM)
                        case .buyNew:
                            BuyView(navPath: $navPath, orderVM: orderVM)
                        case .refill:
                            RefillView(orderVM: orderVM)
                        case .checkout:
                            CheckoutView(
                                cart: orderVM.cart,
                                locations: orderVM.getLocations(),
                                onCancelOrder: {
                                    navPath.removeLast()
                                },
                                onPayWithMomo: {
                                    orderVM.checkoutOrder($0)
                                    navPath.removeLast(navPath.count-1)
                                })
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
    case refill
    case checkout
}
