//
//  ParallaxCarouselScrollApp.swift
//  ParallaxCarouselScroll
//
//  Created by mark on 2023-09-27.
//

import SwiftUI

@main
struct ParallaxCarouselScrollApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
