//
//  HomeView.swift
//  3DParallaxEffect
//
//  Created by mark on 2025-04-10.
//

import SwiftUI

struct HomeView: View {
    // MARK: State Object of Motion Manager
    @StateObject var motionManager: MotionManager = .init()
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.title3)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "person")
                        .font(.title3)
                }
            }
            .foregroundStyle(.white)
            
            Text("Exclusive trips just for you")
                // MARK: Custom Font
                // Note: If The Ffont Don't Work Then Open the Font
                // Then Identify the True Name
                .font(.custom("GabrielaStencilW00-Lightit", size: 25))
                .foregroundStyle(.white)
                .padding(.top, 10)
            
            ParallaxCards()
                .padding(.horizontal, -15)
            
            TabBar()
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Rectangle()
                .fill(Color.BG)
                .ignoresSafeArea()
        }
    }
    
    // MARK: Parallax Cards
    @ViewBuilder
    func ParallaxCards() -> some View {
        TabView(selection: $motionManager.currentSlide) {
            ForEach(sample_places) { place in
                GeometryReader { proxy in
                    let size = proxy.size
                    
                    // MARK: Adding Parallax Effect To Currently Showing Slide
                    ZStack {
                        Image(place.bgName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(x: motionManager.currentSlide.id == place.id ? -motionManager.xValue * 75 : 0)
                            .frame(width: size.width, height: size.height)
                            .clipped()
                        
                        Image(place.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(x: motionManager.currentSlide.id == place.id ? overlayOffset() : 0)
                            .frame(width: size.width, height: size.height)
                            .clipped()
                            .scaleEffect(1.05, anchor: .bottom)
                        
                        VStack(spacing: 10) {
                            Text("FEATURES")
                                .font(.caption)
                                .fontWeight(.semibold)
                            
                            Text(place.placeName)
                                .font(.custom("Gabriela Stencil", size: 45))
                                .shadow(color: .black.opacity(0.3), radius: 15, x: 5, y: 5)
                                .shadow(color: .black.opacity(0.3), radius: 15, x: -5, y: -5)
                            
                            Button {
                                
                            } label: {
                                Text("EXPLORE")
                                    .font(.custom("Gabriela Stencil", size: 14))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background {
                                        ZStack {
                                            Rectangle()
                                                .fill(.black.opacity(0.15))
                                            
                                            Rectangle()
                                                .fill(.white.opacity(0.3))
                                        }
                                    }
                            }
                        }
                        .foregroundStyle(.white.opacity(0.6))
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 60)
                        .offset(x: motionManager.currentSlide.id == place.id ? -motionManager.xValue * 15 : 0)
                    }
                    .frame(width: size.width, height: size.height, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                    // MARK: If You need Smooth Animation
                    // It will Consume Some Memory
                    // So Always Check Memory Usage
//                    .animation(.interactiveSpring(), value: motionManager.xValue)
                }
                .padding(.vertical, 30)
                .padding(.horizontal, 40)
                .tag(place)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onAppear {
            motionManager.detectMotion()
        }
        .onDisappear {
            motionManager.stopMotionUpdates()
        }
    }
    
    func overlayOffset() -> CGFloat {
        return max(-8, min(motionManager.xValue * 7, 8))
    }
    
    // MARK: Tab Bar
    @ViewBuilder
    func TabBar() -> some View {
        let icons: [String] = ["house", "suit.heart", "magnifyingglass"]
        
        HStack(spacing: 0) {
            ForEach(icons, id: \.self) { icon in
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(.white.opacity(0.7))
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    ContentView()
}
