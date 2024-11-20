//
//  Home.swift
//  AnimatedTabIcons
//
//  Created by mark on 2024-05-12.
//

import SwiftUI

struct Home: View {
    /// View Properties
    @State private var activeTab: Tab = .photos
    /// All Tab's
    @State private var allTabs: [AnimatedTab] = Tab.allCases.compactMap { tab -> AnimatedTab in
        return .init(tab: tab)
    }
    /// Bounce Property
    @State private var bouncesDown: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                NavigationStack {
                    VStack {
                        
                    }
                    .navigationTitle(Tab.photos.title)
                }
                .setUpTab(.photos)
                
                NavigationStack {
                    VStack {
                        
                    }
                    .navigationTitle(Tab.chat.title)
                }
                .setUpTab(.chat)
                
                NavigationStack {
                    VStack {
                        
                    }
                    .navigationTitle(Tab.apps.title)
                }
                .setUpTab(.apps)
                
                NavigationStack {
                    VStack {
                        
                    }
                    .navigationTitle(Tab.notifications.title)
                }
                .setUpTab(.notifications)
                
                NavigationStack {
                    VStack {
                        
                    }
                    .navigationTitle(Tab.profile.title)
                }
                .setUpTab(.profile)
            }
            
            Picker("", selection: $bouncesDown) {
                Text("Bounces Down")
                    .tag(true)
                
                Text("Bounces Up")
                    .tag(false)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 15)
            .padding(.bottom, 20)
            
            CustomTabBar()
        }
    }
    
    /// Custom Tab Bar
    @ViewBuilder
    func CustomTabBar() -> some View {
        HStack(spacing: 0) {
            ForEach($allTabs) { $animatedTab in
                let tab = animatedTab.tab
                
                VStack(spacing: 4) {
                    Image(systemName: tab.rawValue)
                        .font(.title2)
                    /// iOS 17 allows us to create SF symbols in different ways, such as discreate, indefinite, etc. I'm going to make use of those APIs to create an animated tab bar
                    /// The SF Symbols 5 app allows you to view the animations of the symbols. You can see that there are modification properties for the chosen symbol on the right-hand side. These may be combined to get the desired effect, and once you have it, you can copy the animation and quickly add it to SwiftUI Image using the new SymbolEffect modifier
                    /// The reason why the animation occures twice is that the symbolEffect modifier animates the image when the value changes. To avoid this, we can use Transaction() to tell SwiftUI to disable animation for this particular transaction.
                        .symbolEffect(bouncesDown ? .bounce.down.byLayer : .bounce.up.byLayer, value: animatedTab.isAnimating)
                    
                    Text(tab.title)
                        .font(.caption2)
                        .textScale(.secondary)
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(activeTab == tab ? Color.primary : Color.gray.opacity(0.8))
                .padding(.top, 15)
                .padding(.bottom, 10)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.bouncy, completionCriteria: .logicallyComplete, {
                        activeTab = tab
                        animatedTab.isAnimating = true
                    }, completion: {
                        /// As you can notice, the animation is happening only once since we didn't reset the animation status to nil. That's the reason why I wrapped the animation inside the new WithAnimation completion handler, so that I can reset the status to nil once the animation completes.
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            animatedTab.isAnimating = nil
                        }
                    })
                }
            }
        }
        .background(.bar)
    }
}

#Preview {
    ContentView()
}

extension View {
    @ViewBuilder
    func setUpTab(_ tab: Tab) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .tag(tab)
            .toolbar(.hidden, for: .tabBar)
    }
}
