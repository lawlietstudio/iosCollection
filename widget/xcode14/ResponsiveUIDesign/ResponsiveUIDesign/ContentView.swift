//
//  ContentView.swift
//  ResponsiveUIDesign
//
//  Created by mark on 2025-01-03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ResponsiveView { props in
            Home(props: props)
        }
    }
}

#Preview {
    ContentView()
}
