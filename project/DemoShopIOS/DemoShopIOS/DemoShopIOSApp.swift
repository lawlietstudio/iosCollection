//
//  DemoShopIOSApp.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 21/8/2022.
//

import SwiftUI

@main
struct DemoShopIOSApp: App {
    var body: some Scene {
        WindowGroup {
            RootView {
                //Put the view you want your app to present here
                ProductListView(categoryId: 0)
                    //add necessary environment objects here
            }
        }
    }
}
