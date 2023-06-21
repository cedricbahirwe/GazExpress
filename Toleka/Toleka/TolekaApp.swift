//
//  TolekaApp.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 21/06/2023.
//

import SwiftUI

@main
struct TolekaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
