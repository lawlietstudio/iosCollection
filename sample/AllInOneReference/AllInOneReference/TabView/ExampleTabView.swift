//
//  ExampleTabView.swift
//  AllInOneReference
//
//  Created by mark on 2023-05-19.
//

import SwiftUI

struct ExampleTabView: View {
    var body: some View {
        TabView {
            GroupBox(label: Text("This is the title 1")) {
                Label("Some item 1", systemImage: "checkmark.circle.fill")
                Label("Some item 2", systemImage: "checkmark.circle.fill")
                Label("Some item 3", systemImage: "checkmark.circle.fill")
                Label("Some item 4", systemImage: "checkmark.circle.fill")
            }
            .padding()
            
            GroupBox(label: Text("This is the title 2")) {
                Label("Some item 1", systemImage: "checkmark.circle.fill")
                Label("Some item 2", systemImage: "checkmark.circle.fill")
                Label("Some item 3", systemImage: "checkmark.circle.fill")
                Label("Some item 4", systemImage: "checkmark.circle.fill")
            }
            .padding()
            GroupBox(label: Text("This is the title 3")) {
                Label("Some item 1", systemImage: "checkmark.circle.fill")
                Label("Some item 2", systemImage: "checkmark.circle.fill")
                Label("Some item 3", systemImage: "checkmark.circle.fill")
                Label("Some item 4", systemImage: "checkmark.circle.fill")
            }
            .padding()
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .indexViewStyle(.page)
        .frame(width: UIScreen.main.bounds.size.width / 2)
        .padding(-50)
    }
}

struct ExampleTabView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleTabView()
    }
}
