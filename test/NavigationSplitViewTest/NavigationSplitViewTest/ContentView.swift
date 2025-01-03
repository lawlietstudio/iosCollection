//
//  ContentView.swift
//  NavigationSplitViewTest
//
//  Created by mark on 2024-11-29.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedItem: String? = nil
    
    var sidebarItems = ["Home", "Profile", "Settings"]
    
    var body: some View {
        NavigationSplitView {
            // Sidebar
            List(sidebarItems, id: \.self, selection: $selectedItem) {
                item in
                Text(item)
                    .tag(item)
            }
            
        } detail: {
            if let selectedItem {
                
            }
        }
    }
}

#Preview {
    ContentView()
}
