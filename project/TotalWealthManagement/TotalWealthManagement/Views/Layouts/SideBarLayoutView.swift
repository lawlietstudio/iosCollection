//
//  SideBarLayoutView.swift
//  TotalWealthManagement
//
//  Created by mark on 2024-11-20.
//

import SwiftUI

/// Tabs
enum TabState: String, CaseIterable {
    case assets = "Assets Overview"
    case balance = "Balance Projection"
    
    var symbolImage: String {
        switch self {
        case .assets: "chart.pie"
        case .balance: "chart.line.uptrend.xyaxis"
        }
    }
    
}


struct SideBarLayoutView: View {
    /// View Properties
    @State private var activeTab: TabState = .balance
    /// Gesture Properties
    @State private var offset: CGFloat = 0
    @State private var lastDragOffset: CGFloat = 0
    @State private var progress: CGFloat = 0
    @State private var panGesture: UIPanGestureRecognizer?
    /// Naviagtion Path
    @State private var navigationPath: NavigationPath = .init()
    
    var body: some View {
        AdaptiveView { size, isLandscape in
            let sideBarWidth: CGFloat = isLandscape ? 220 : 250
            let localIsLandscape = false
            let layout = localIsLandscape ? AnyLayout(HStackLayout(spacing: 0)) : AnyLayout(ZStackLayout(alignment: .leading))
            
            NavigationStack(path: $navigationPath) {
                layout {
                    SideBarView(path: $navigationPath, activeTab: $activeTab)
                    {
                        hideSideBar()
                    }
                        .frame(width: sideBarWidth)
                        .offset(x: localIsLandscape ? 0 : -sideBarWidth)
                        .offset(x: localIsLandscape ? 0 : offset)
                    
                    TabView(selection: $activeTab, content: {
                        Tab(TabState.assets.rawValue, systemImage: TabState.assets.symbolImage, value: .assets) {
                            AssetsView(dismiss: { showSideBar(sideBarWidth: sideBarWidth)})
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                        
                        Tab(TabState.balance.rawValue, systemImage: TabState.balance.symbolImage, value: .balance) {
                            BalanceView(dismiss: { showSideBar(sideBarWidth: sideBarWidth)} )
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                    })
                    .tabViewStyle(.sidebarAdaptable)
                    .animation(.snappy(duration: 0.25), value: activeTab)
                    .overlay {
                        Rectangle()
                            .fill(.black.opacity(0.25))
                            .ignoresSafeArea()
                            .opacity(localIsLandscape ? 0 : progress)
                            .onTapGesture {
                                hideSideBar()
                            }
                    }
                    .offset(x: localIsLandscape ? 0 : offset)
                }
                .customeGestureModifier(offset: $offset, lastDragOffset: $lastDragOffset, progress: $progress, panGesture: $panGesture, sideBarWidth: sideBarWidth, isLandscape: localIsLandscape)
                .toolbarBackground(.hidden, for: .navigationBar)
//                .animation(.snappy(duration: 0.25), value: offset)
                .toolbarVisibility(.hidden, for: .navigationBar)
                
                .onChange(of: isLandscape) { oldValue, newValue in
                    panGesture?.isEnabled = !newValue
                }
                .navigationDestination(for: String.self) { value in
                    Text("Hello, This is Detail \(value) View")
                        .navigationTitle(value)
                }
            }
        }
    }
    
    func showSideBar(sideBarWidth: CGFloat) {
        withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
            offset = sideBarWidth
            progress = 1
            lastDragOffset = sideBarWidth
        }
    }
    
    func hideSideBar() {
        withAnimation(.snappy(duration: 0.25, extraBounce: 0))
        {
            progress = 0
            offset = 0
            lastDragOffset = 0
        }
    }
}

struct CustomeGestureModifier: ViewModifier {
    @Binding public var offset: CGFloat
    @Binding public var lastDragOffset: CGFloat
    @Binding public var progress: CGFloat
    @Binding public var panGesture: UIPanGestureRecognizer?
    let sideBarWidth: CGFloat
    let isLandscape: Bool
    
    func body(content: Content) -> some View {
        content
            .gesture(
                CustomGesture(isEnabled: !isLandscape) { gesture in
                    if panGesture == nil { panGesture = gesture }
                    
                    let state = gesture.state
                    let translation = gesture.translation(in: gesture.view).x + lastDragOffset
                    let velocity = gesture.velocity(in: gesture.view).x / 3
                    
                    if state == .began || state == .changed {
//                        /// onChanged
//                        offset = max(min(translation, sideBarWidth), 0)
//                        /// Storing Drag Progress, for fading tab view when drawing
//                        progress = max(min(offset / sideBarWidth, 1), 0)
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
    }
}

extension View {
    func customeGestureModifier(offset: Binding<CGFloat>, lastDragOffset: Binding<CGFloat>, progress: Binding<CGFloat>, panGesture: Binding<UIPanGestureRecognizer?>, sideBarWidth: CGFloat, isLandscape: Bool) -> some View {
        modifier(CustomeGestureModifier(offset: offset, lastDragOffset: lastDragOffset, progress: progress, panGesture: panGesture, sideBarWidth: sideBarWidth, isLandscape: isLandscape))
    }
}

struct SideBarView: View {
    @Binding var path: NavigationPath
    @Binding var activeTab: TabState
    
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
                    
                    Text("Total Wealth Management")
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    Text("The all in one personal financial tool")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    
                    /// Side Bar Navigaton Items
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(TabState.allCases, id: \.rawValue) {
                            tabState in
                            SideBarActionButton(value: tabState) {
                                toggleSideBar()
                                activeTab = tabState
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
    func SideBarActionButton(value: TabState, action: @escaping () -> ()) -> some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: value.symbolImage)
                    .font(.title3)
                    .frame(width: 30)
                
                Text(value.rawValue)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                
                Spacer(minLength: 0)
            }
            .foregroundColor(Color.primary)
            .padding(.vertical, 10)
            .contentShape(.rect)
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
