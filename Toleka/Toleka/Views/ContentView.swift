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
                    print("New value", newValue)
                    if newValue {
                        navPath.removeLast(navPath.count)
                    }
                }
                .onAppear() {
                    print("On Appear", isLoggedIn)
                    if isLoggedIn {
                        navPath.append(NavRoute.home)
                    }
                    
                }
                .navigationDestination(for: NavRoute.self) { newRoute in
                    switch newRoute {
                    case .home:
                        HomeView(navPath: $navPath)
                    case .profile:
                        ProfileView()
                    case .cart:
                        CartView()
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
