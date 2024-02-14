//
//  ContentView.swift
//  MatchedGeometryEffectsFullScreenCover
//
//  Created by mark on 2023-07-11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("NavigationStack")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
