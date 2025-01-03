//
//  Home.swift
//  ResponsiveUI
//
//  Created by mark on 2024-09-08.
//

import SwiftUI

/// Tabs
enum TabState: String, CaseIterable {
    case home = "Home"
    case search = "Search"
    case notifications = "Notifications"
    case profile = "Profile"
    
    var symbolImage: String {
        switch self {
        case .home: "house"
        case .search: "magnifyingglass"
        case .notifications: "bell"
        case .profile: "person.crop.circle"
        }
    }
}

struct Home: View {
    /// View Properties
    @State private var activeTab: TabState = .home
    /// Gesture Properties
    @State private var offset: CGFloat = 0
    @State private var lastDragOffset: CGFloat = 0
    @State private var progress: CGFloat = 0
    @State private var panGesture: UIPanGestureRecognizer?
    /// Naviagtion Path
    @State private var navigationPath: NavigationPath = .init()
    
    var body: some View {
        AdaptiveView { size, _ in
            var isLandscape = false
            let sideBarWidth: CGFloat = isLandscape ? 220 : 250
            let layout = isLandscape ? AnyLayout(HStackLayout(spacing: 0)) : AnyLayout(ZStackLayout(alignment: .leading))
            
            NavigationStack(path: $navigationPath) {
                layout {
                    SideBarView(path: $navigationPath)
                    {
                        toggleSideBar()
                    }
                        .frame(width: sideBarWidth)
                        .offset(x: isLandscape ? 0 : -sideBarWidth)
                        .offset(x: isLandscape ? 0 : offset)
                    
                    TabView(selection: $activeTab, content: {
                        Tab(TabState.home.rawValue, systemImage: TabState.home.symbolImage, value: .home) {
                            Text("Home")
                        }
                        
                        Tab(TabState.search.rawValue, systemImage: TabState.search.symbolImage, value: .search) {
                            Text("Search")
                        }
                        
                        Tab(TabState.notifications.rawValue, systemImage: TabState.notifications.symbolImage, value: .notifications) {
                            Text("Notifications")
                        }
                        
                        Tab(TabState.profile.rawValue, systemImage: TabState.profile.symbolImage, value: .profile) {
                            Text("Profile")
                        }
                    })
                    .navigationTitle("Assets")
                    .tabViewStyle(.tabBarOnly)
                    .overlay {
                        Rectangle()
                            .fill(.black.opacity(0.25))
                            .ignoresSafeArea()
                            .opacity(isLandscape ? 0 : progress)
                            .onTapGesture {
                                toggleSideBar()
                            }
                    }
                    .offset(x: isLandscape ? 0 : offset)
                }
                .toolbarVisibility(.hidden, for: .navigationBar)
                .gesture(
                    CustomGesture(isEnabled: !isLandscape) { gesture in
                        if panGesture == nil { panGesture = gesture }
                        
                        let state = gesture.state
                        let translation = gesture.translation(in: gesture.view).x + lastDragOffset
                        let velocity = gesture.velocity(in: gesture.view).x / 3
                        
                        if state == .began || state == .changed {
                            /// onChanged
                            offset = max(min(translation, sideBarWidth), 0)
                            /// Storing Drag Progress, for fading tab view when drawing
                            progress = max(min(offset / sideBarWidth, 1), 0)
                        } else {
                            /// onEnded
                            withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                                if (velocity + offset) > (sideBarWidth * 0.5) {
                                    /// Expand Fully
                                    offset = sideBarWidth
                                    progress = 1
                                } else {
                                    /// Reset to zero
                                    offset = 0
                                    progress = 0
                                }
                            }
                            
                            /// Saving last drag offset
                            lastDragOffset = offset
                        }
                    }
                )
                .onChange(of: isLandscape) { oldValue, newValue in
                    panGesture?.isEnabled = !newValue
                }
                .navigationDestination(for: String.self) { value in
                    Text("Hello, This is Detail \(value) View")
                        .navigationTitle(value)
                }
                //            .gesture(DragGesture()
                //                .onChanged({ value in
                //                    let translation = value.translation.width + lastDragOffset
                //                    offset = max(min(translation, sideBarWidth), 0)
                //                    /// Storing Drag Progress, for fading tab view when drawing
                //                    progress = max(min(offset / sideBarWidth, 1), 0)
                //                }).onEnded({ value in
                //                    let velocity = value.translation.width / 3
                //
                //                    withAnimation {
                //                        if (velocity + offset) > (sideBarWidth * 0.5) {
                //                            /// Expand Fully
                //                            offset = sideBarWidth
                //                            progress = 1
                //                        } else {
                //                            /// Reset to zero
                //                            offset = 0
                //                            progress = 0
                //                        }
                //                    }
                //                }))
            }
        }
    }
    
    func toggleSideBar() {
        withAnimation(.snappy(duration: 0.25, extraBounce: 0))
        {
            progress = 0
            offset = 0
            lastDragOffset = 0
        }
    }
}

struct SideBarView: View {
    @Binding var path: NavigationPath
    var toggleSideBar: () -> ()
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let isSidesHavingValues = safeArea.leading != 0 || safeArea.trailing != 0
            
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 6) {
                    Image(.pic)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(.circle)
                    
                    Text("iJustine")
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    Text("@iJustine")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    
                    HStack(spacing: 4) {
                        Text("3.1K")
                            .fontWeight(.semibold)
                        
                        Text("Following")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        Text("1.8M")
                            .fontWeight(.semibold)
                            .padding(.leading, 5)
                        
                        Text("Following")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    .font(.system(size: 14))
                    .lineLimit(1)
                    .padding(.top, 5)
                    
                    /// Side Bar Navigaton Items
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(SideBarAction.allCases, id: \.rawValue) {
                            action in
                            SideBarActionButton(value: action) {
                                toggleSideBar()
                                path.append(action.rawValue)
                            }
                        }
                    }
                    .padding(.top, 25)
                }
                .padding(.vertical, 15)
                .padding(.horizontal, isSidesHavingValues ? 5 : 15)
            }
            .scrollClipDisabled()
            .scrollIndicators(.hidden)
            .background {
                Rectangle()
                    .fill(.background)
                    .overlay(alignment: .trailing, content: {
                        Rectangle()
                            .fill(.gray.opacity(0.35))
                            .frame(width: 1)
                    })
                    .ignoresSafeArea()
            }
        }
    }
    
    @ViewBuilder
    func SideBarActionButton(value: SideBarAction, action: @escaping () -> ()) -> some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: value.symbolImage)
                    .font(.title3)
                    .frame(width: 30)
                
                Text(value.rawValue)
                    .fontWeight(.semibold)
                
                Spacer(minLength: 0)
            }
            .foregroundColor(Color.primary)
            .padding(.vertical, 10)
            .contentShape(.rect)
        }
    }
}

/// Side Bar Actions
enum SideBarAction: String, CaseIterable {
    case communities = "Communities"
    case bookmarks = "Bookmarks"
    case lists = "Lists"
    case messages = "Messages"
    case monetization = "Monetization"
    case settings = "Settings"
    
    var symbolImage: String {
        switch self {
        case .communities: "person.2"
        case .bookmarks: "bookmark"
        case .lists: "list.bullet.clipboard"
        case .messages: "message.badge.waveform"
        case .monetization: "banknote"
        case .settings: "gearshape"
        }
    }
}

/// Custome Gesture
struct CustomGesture: UIGestureRecognizerRepresentable {
    var isEnabled: Bool
    var handle: (UIPanGestureRecognizer) -> ()
    func makeUIGestureRecognizer(context: Context) -> UIPanGestureRecognizer {
        let gesture = UIPanGestureRecognizer()
        return gesture
    }
    
    func updateUIGestureRecognizer(_ recognizer: UIPanGestureRecognizer, context: Context) {
        recognizer.isEnabled = isEnabled
    }
    
    func handleUIGestureRecognizerAction(_ recognizer: UIPanGestureRecognizer, context: Context) {
        handle(recognizer)
    }
}

/// Adaptive View
struct AdaptiveView<Content: View>: View {
    var showsSideBarOnlyPadPortrait: Bool = true
    @ViewBuilder var content: (CGSize, Bool) -> Content
    @Environment(\.horizontalSizeClass) private var hClass
    var body: some View {
        GeometryReader {
            let size = $0.size
            let isLandscape = size.width > size.height || (hClass == .regular && showsSideBarOnlyPadPortrait)
            
            content(size, isLandscape)
        }
    }
}

#Preview {
    ContentView()
}
