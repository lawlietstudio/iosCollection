//
//  SimpleCoreDataApp.swift
//  SimpleCoreData
//
//  Created by mark on 2023-06-14.
//

import SwiftUI

@main
struct SimpleCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
