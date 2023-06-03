//
//  VStacklimitationView.swift
//  AllInOneReference
//
//  Created by mark on 2023-05-19.
//

import SwiftUI

struct VStacklimitationView: View {
    /// Offset x of the view drag.
    @State var dragOffset: CGFloat = .zero
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged(dragChanged)
            .onEnded(dragEnded)
    }
    
    private func dragChanged(_ value: DragGesture.Value) {
        var offset: CGFloat = 500
        if value.translation.width > 0 {
            offset = min(offset, value.translation.width)
        } else {
            offset = max(-offset, value.translation.width)
        }
        
        /// set drag offset
        dragOffset = offset
        print(dragOffset)
    }
    
    private func dragEnded(_ value: DragGesture.Value) {
//        dragOffset = .zero
        
        
        /// Defines the drag threshold
        /// At the end of the drag, if the drag value exceeds the drag threshold,
        /// the active view will be toggled
        /// default is one third of subview
    }
    var body: some View {
        // https://stackoverflow.com/questions/61178868/swiftui-random-extra-argument-in-call-error
        VStack { // A VStack call take up to 10 children
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)        
            HStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Group {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    Text("Hello, World!")
                }.foregroundColor(.blue)
                Text("Hello, World!")
            }
            .offset(CGSize.init(width: dragOffset, height: 0))
            .gesture(dragGesture)
            .foregroundColor(.red)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct VStacklimitationView_Previews: PreviewProvider {
    static var previews: some View {
        VStacklimitationView()
    }
}
