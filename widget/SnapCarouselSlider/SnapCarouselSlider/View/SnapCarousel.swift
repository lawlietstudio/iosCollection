//
//  SnapCarousel.swift
//  SnapCarouselSlider
//
//  Created by mark on 2023-05-28.
//

import SwiftUI

// To for Accepting List....
struct SnapCarousel<Content: View, T: Identifiable>: View {
    var content: (T) -> Content
    var list: [T]
    
    // Properties...
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    
    // Offset...
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    init(spacing: CGFloat = 15, trailingSpace: CGFloat = 100, index: Binding<Int>, items: [T], @ViewBuilder content: @escaping (T)->Content) {
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
    }
    
    var body: some View {
        GeometryReader { proxy in
            
            // Setting currect Width for snap Carousel....
            
            // One Sided Snap Carosal
            
            let width = proxy.size.width - (trailingSpace - spacing)
            let adjustmentWidth = (trailingSpace / 2) - spacing
            let isAdjustment = true
            
            HStack(spacing: spacing) {
                ForEach(list) { item in
                    content(item)
                        .frame(width: proxy.size.width - trailingSpace)
                }
            }
            // Spacing will be horizontal padding
            .padding(.horizontal, spacing)
            // setting only after 0th index
            .offset(x: CGFloat(currentIndex) * -width + (isAdjustment ? (currentIndex != 0 ? adjustmentWidth : 0) : 0) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, transaction in
                        out = value.translation.width
                    })
                    .onEnded({ value in
                        // Updating Current Index....
                        let offsetX = value.translation.width
                        
                        // were going to convert the translation into progress (0 - 1)
                        // and round the value
                        // based on the progress incresing or decreasing the currentIndex...
                        let progress = -offsetX / width
                        
                        let roundIndex = progress.rounded()
                        
                        // currentIndex += Int(roundIndex)
                        currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        
                        // updating index...
                        currentIndex = index
                    })
                    .onChanged({ value in
                        // Updating Current Index....
                        let offsetX = value.translation.width
                        
                        // were going to convert the translation into progress (0 - 1)
                        // and round the value
                        // based on the progress incresing or decreasing the currentIndex...
                        let progress = -offsetX / width
                        
                        let roundIndex = progress.rounded()
                        
                        // currentIndex += Int(roundIndex)
                        index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                    })
            )
            // Animation when offset = 0
            .animation(.easeInOut, value: offset == 0)
        }
    }
}

struct SnapCarousel_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
