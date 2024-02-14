//
//  _0231226CoreDataManyApp.swift
//  20231226CoreDataMany
//
//  Created by mark on 2023-12-26.
//

import SwiftUI

@main
struct _0231226CoreDataManyApp: App {
    // Create a dataController instance.
    let dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            DisplayableProductListView()
            // Pass the dataController to the environment.
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
