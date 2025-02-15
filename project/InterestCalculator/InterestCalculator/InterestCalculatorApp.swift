//
//  InterestCalculatorApp.swift
//  InterestCalculator
//
//  Created by mark on 2024-11-17.
//

import SwiftUI
import SwiftData

@main
struct InterestCalculatorApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            InterestCalculationView()
        }
        .modelContainer(sharedModelContainer)
    }
}
