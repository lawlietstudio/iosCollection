//
//  SkeletonModifier.swift
//  SkeletonLoadingAnimation
//
//  Created by mark on 2025-04-14.
//

import SwiftUI

/*
 In our previous video, we demonstrated how to create a Skeleton Loading UI by devloping a custom Skeleton View. This method offers significant
 control over the Skeleton View's shape & appearance. However, I received a few comments requesting a simpler and more easy-to-use approach that leveragees the default "reacted" modifier.
 To address this, I've created  ashort 3-minute video that shows how to modify the existing code to utilize the redacted modifier and develop a new, easy-to-use custom skeleton modifier for creating mock leading screens.
 */

extension View {
    func skeleton(isRedacted: Bool) -> some View {
        self
            .modifier(SkeletonModifier(isRedacted: isRedacted))
    }
}

struct SkeletonModifier: ViewModifier {
    var isRedacted: Bool
    /// View Properties
    @State private var isAnimating: Bool = false
    @Environment(\.colorScheme) private var scheme
    
    func body(content: Content) -> some View {
        content
            .redacted(reason: isRedacted ? .placeholder : [])
            /// Skeleton Effect
            .overlay {
                if isRedacted {
                    GeometryReader {
                        let size = $0.size
                        let skeletonWidth = size.width / 2
                        /// Limiting blur radius to 30+
                        let blurRadius = max(skeletonWidth / 2, 30)
                        let blurDiameter = blurRadius * 2
                        /// Movement Offsets
                        let minX = -(skeletonWidth + blurDiameter)
                        let maxX = size.width + skeletonWidth + blurDiameter
                        
                        Rectangle()
                            .fill(scheme == .dark ? .white : .black)
                            .frame(width: skeletonWidth, height: size.height * 2)
                            .frame(height: size.height)
                            .blur(radius: blurRadius)
                            .rotationEffect(.init(degrees: rotation))
                            /// Moving from left-right in-definetely
                            .offset(x: isAnimating ? maxX : minX)
                    }
                    /// The skeleton view has a specific shape, which we used to clip the view. However, in this case, no shapes are provided. Instead, we can utilize the mask modifier to clip the skeleton effect view using its own placeholder content view.
                    .mask({
                        content.redacted(reason: .placeholder)
                    })
                    .blendMode(.softLight)
                    .task {
                        guard !isAnimating else { return }
                        withAnimation(animation) {
                            isAnimating = true
                        }
                    }
                    .onDisappear {
                        /// Stopping Animation
                        isAnimating = false
                    }
                    .transaction {
                        if $0.animation != animation {
                            $0.animation = .none
                        }
                    }
                }
            }
    }
    
    /// Customizable Properties
    var rotation: Double {
        return 5
    }
    
    var animation: Animation{
        .easeInOut(duration: 1.5).repeatForever(autoreverses: false)
    }
}

#Preview {
    ContentView()
}
