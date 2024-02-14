//
//  ViewBuilderView.swift
//  AllInOneReference
//
//  Created by mark on 2023-05-27.
//

import SwiftUI

struct ViewBuilderView: View {
    var body: some View {
        createViewWithViewBuilder(usingCondition: true)
        createViewWithViewBuilder(usingCondition: false)
        Divider()
        createView(usingCondition: true)
        createView(usingCondition: false)
    }
    
    /// some View, which means the return type must be an opaque type that conforms to the View protocol
    
    @ViewBuilder
    func createViewWithViewBuilder(usingCondition: Bool) -> some View {
        if usingCondition {
            Text("Condition is true")
                .foregroundColor(.green)
        } else {
            VStack {
                Text("Condition is false")
                    .foregroundColor(.red)
                Text("Fallback View")
                    .foregroundColor(.red)
            }
        }
    }
    
///    not using @ViewBuilder doesn't prevent you from composing views, it can make your code less concise and require additional manual handling of container views. @ViewBuilder simplifies the process by allowing you to pass multiple views as a single block of code and automatically handles the composition for you.
    ///    AnyView is used to erase the underlying types and provide a consistent return type of some View.
    ///    it's worth noting that using AnyView can have a small performance impact, as it hides the specific view types, potentially limiting certain optimizations by the SwiftUI framework. Therefore, it's generally recommended to use AnyView sparingly and only when necessary.
    
    func createView(usingCondition: Bool) -> some View {
        if usingCondition {
            return AnyView(Text("Condition is true")
                .foregroundColor(.green))
        } else {
            return AnyView(VStack {
                Text("Condition is false")
                    .foregroundColor(.red)
                Text("Fallback View")
                    .foregroundColor(.red)
            })
        }
    }
}

struct ViewBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        ViewBuilderView()
    }
}
