//
//  ContentView.swift
//  BookAppUIWithAnime
//
//  Created by mark on 2023-07-04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
