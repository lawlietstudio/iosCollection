//
//  iOS26StyleOnBoarding.swift
//  OnBoardingAnimation
//
//  Created by mark on 2026-02-21.
//

import SwiftUI

struct iOS26StyleOnBoarding: View {
    var tint: Color = .blue
    var items: [Item]
    /// View Properties
    @State private var currentIndex: Int = 0
    @State private var screenshotSize: CGSize = .zero
    
    var body: some View {
        ZStack(alignment: .bottom) {
            BackButton()
            
            ScreenshotView()
                .compositingGroup()
                .scaleEffect(
                    items[currentIndex].zoomScale,
                    anchor: items[currentIndex].zoomAnchor
                )
                .padding(.top, 35)
                .padding(.horizontal, 30)
                .padding(.bottom, 220)
            
            VStack(spacing: 10) {
                TextContentView()
                IndicatorView()
                ContinueButton()
            }
            .padding(.top, 20)
            .padding(.horizontal, 15)
            .frame(height: 210)
            .background {
                VariableGlassBlur(15)
            }
        }
        .preferredColorScheme(.dark)
    }
    
    /// Screenshot View
    @ViewBuilder
    func ScreenshotView() -> some View {
        let shape = ConcentricRectangle(corners: .concentric, isUniform: true)
        
        GeometryReader {
            let size = $0.size
            
            Rectangle()
                .fill(.black)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(items.indices, id: \.self) { index in
                        let item = items[index]
                        
                        Group {
                            if let screenshot = item.screenshot {
                                Image(uiImage: screenshot)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .onGeometryChange(for: CGSize.self) {
                                        $0.size
                                    } action: { newValue in
                                        screenshotSize = newValue
                                    }
                                    .clipShape(shape)

                            } else {
                                Rectangle()
                                    .fill(.black)
                            }
                        }
                        .frame(width: size.width, height: size.height)
                        /* So instead of manually calculating the fitting size for the screenshots, I'm going to use the onGeometryChange modifier to read the fiiting image sizes and going to use that to draw the bezels on top of the screenshots!
                        */
        
                    }
                }
                .scrollTargetLayout()
            }
            .scrollDisabled(true)
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .scrollPosition(id: .init(get: {
                return currentIndex
            }, set: { _ in }))
        }
        .clipShape(shape)
        .overlay {
            if screenshotSize != .zero {
                /// Device Frame UI
                ZStack {
                    shape
                        .stroke(.white, lineWidth: 6)
                    
                    shape
                        .stroke(.black, lineWidth: 4)
                    
                    shape
                        .stroke(.black, lineWidth: 6)
                        .padding(4)
                }
                .padding(-6)
            }
        }
        .frame(
            maxWidth: screenshotSize.width == 0 ? nil : screenshotSize.width,
            maxHeight: screenshotSize.height == 0 ? nil : screenshotSize.height
        )
        .containerShape(RoundedRectangle(cornerRadius: deviceCornerRadius))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    /// Text Content View
    @ViewBuilder
    func TextContentView() -> some View {
        GeometryReader {
            let size = $0.size
            
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(items.indices, id: \.self) { index in
                        let item = items[index]
                        let isActive = currentIndex == index
                        
                        VStack(spacing: 6) {
                            Text(item.title)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .foregroundStyle(.white)
                            
                            Text(item.subtitle)
                                .font(.callout)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white.opacity(0.8))
                        }
                        .frame(width: size.width)
                        .compositingGroup()
                        /// Only The current Item is visible other are blurred out!
                        .blur(radius: isActive ? 0 : 30)
                        .opacity(isActive ? 1 : 0)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .scrollDisabled(true)
            .scrollTargetBehavior(.paging)
            .scrollClipDisabled()
            .scrollPosition(id: .init(get: {
                return currentIndex
            }, set: { _ in  }))
        }
    }
    
    /// Indicator View
    @ViewBuilder
    func IndicatorView() -> some View {
        HStack(spacing: 6)
        {
            ForEach(items.indices, id: \.self) { index in
                let isActive: Bool = index == currentIndex
                
                Capsule()
                    .fill(.white.opacity(isActive ? 1 : 0.4))
                    .frame(width: isActive ? 25 : 6, height: 6)
            }
            .scrollTargetLayout()
        }
        .padding(.bottom, 5)
    }
    
    /// Bottom Continue Button
    @ViewBuilder
    func ContinueButton() -> some View {
        Button {
            withAnimation(animation) {
                currentIndex = min(currentIndex + 1, items.count - 1)
            }
        } label: {
            Text(currentIndex == items.count - 1 ? "Get Started" : "Continue")
                .fontWeight(.medium)
                .contentTransition(.numericText())
                .padding(.vertical, 6)
        }
        .tint(tint)
        .buttonStyle(.glassProminent)
        .buttonSizing(.flexible)
        .padding(.horizontal, 30)
    }
    
    /// Back Button
    @ViewBuilder
    func BackButton() -> some View {
        Button {
            withAnimation(animation) {
                currentIndex = max(currentIndex - 1, 0)
            }
        } label : {
            Image(systemName: "chevron.left")
                .font(.title3)
                .frame(width: 20, height: 30)
        }
        .buttonStyle(.glass)
        .buttonBorderShape(.circle)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.leading, 15)
        .padding(.top, 5)
    }
    
    /// Variable Glass Effect Blur
    @ViewBuilder
    func VariableGlassBlur(_ radius: CGFloat) -> some View {
        let tint: Color = .black.opacity(0.5)
        Rectangle()
            .fill(.clear)
            .glassEffect(.clear.tint(tint), in: .rect)
            .blur(radius: radius)
            .padding([.horizontal, .bottom], -radius * 2)
            .ignoresSafeArea()
    }
    
    var deviceCornerRadius: CGFloat {
        /*
         Why not use a fixed corner radius?
         
         The reason is that when we use a fixed corner radius, it becomes too circular for smaler devices and too rectangular for larger devices. Instead of using a fixed value, I'll calculae the corner radius based on the ratio of the actual creenshot size to the currenct screenshot size.
         
         Here, the "actualCornerRadius" value represents the actual radius of the screenshot itself
         
         Therefore, update this value according to your screenshot
         */
        if let imageSize = items.first?.screenshot?.size {
            let ratio = screenshotSize.height / imageSize.height
            let actualCornerRadius: CGFloat = 190
            return actualCornerRadius * ratio
        }
        
        return 0
    }
    
    struct Item: Identifiable {
        var id: Int
        var title: String
        var subtitle: String
        var screenshot: UIImage?
        var zoomScale: CGFloat = 1
        var zoomAnchor: UnitPoint = .center
    }
    
    /// Customize it according to your needs!
    var animation: Animation {
        .interpolatingSpring(duration: 0.65, bounce: 0, initialVelocity: 0)
    }
}

#Preview {
    ContentView()
}
