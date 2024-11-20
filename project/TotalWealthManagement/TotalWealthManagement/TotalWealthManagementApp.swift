//
//  TotalWealthManagementApp.swift
//  TotalWealthManagement
//
//  Created by mark on 2024-11-17.
//

import SwiftUI
import SwiftData

@main
struct TotalWealthManagementApp: App {
    let container: ModelContainer
    
    init() {
        do {
            let schema = Schema([
                Asset.self,
                CurrencyRate.self
            ])
            
            let modelConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false
            )
            
            container = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            AssetsView()
        }
        .modelContainer(container)
    }
}
