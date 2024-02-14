//
//  ContentView.swift
//  SimpleToDo
//
//  Created by mark on 2023-06-14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("To-Do")
        }
    }
}
