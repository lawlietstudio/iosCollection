//
//  Home.swift
//  ScrollableTabBar
//
//  Created by mark on 2024-04-29.
//

import SwiftUI

struct Home: View {
    /// View Properties
    @State private var tabs: [TabModel] = [
        .init(id: TabModel.Tab.research),
        .init(id: TabModel.Tab.development),
//        .init(id: TabModel.Tab.analytics),
//        .init(id: TabModel.Tab.audience),
//        .init(id: TabModel.Tab.privacy)
    ]
    @State private var activeTab: TabModel.Tab? = .research
    @State private var tabBarScrollState: TabModel.Tab?
    @State private var mainViewScrollState: TabModel.Tab?
    @State private var progress : CGFloat = .zero
    var body: some View {
        HeaderView()
        CustomTabBar()
        
        
        /// Main VIew
        GeometryReader {
            let size = $0.size
            
            // With ios 17, we can now create paging views more easily then ever before it. It is important to note that each tab view within the scrollview must be full screen width, else, paging will not work properly
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    /// YOUR INDIVIDUAL TAB VIEWS
                    ForEach(tabs) { tab in
                        Text(tab.id.rawValue)
                            .frame(width: size.width, height: size.height)
                            .contentShape(.rect)
                    }
                }
                .scrollTargetLayout()
                .rect { rect in
                    progress = -rect.minX / size.width
                }
            }
            // It is important to notice that the scroll position mush match the precise data type of the id supplied in the ForEach loop, In this example, the id is a Tab enum, this the mainViewScrollState property is also a Tab data type
            .scrollPosition(id: $mainViewScrollState)
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.paging)
            .onChange(of: mainViewScrollState) { oldValue, newValue in
                if let newValue {
                    withAnimation(.snappy) {
                        tabBarScrollState = newValue
                        activeTab = newValue
                    }
                }
            }
        }
    }
    
    /// Header View
    @ViewBuilder
    func HeaderView() -> some View {
        HStack {
            Image(.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .clipShape(.circle)
            Text("Goblin")
                .font(.custom("SnellRoundhand-Bold", size: 24))
            
            Spacer()
            
            Button("", systemImage: "plus.circle") {
                
            }
            .font(.title2)
            .tint(.primary)
            
            Button("", systemImage: "bell") {
                
            }
            .font(.title2)
            .tint(.primary)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(.pic)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .clipShape(.circle)
            })
        }
        .padding(15)
        /// Divider
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(.gray.opacity(0.3))
                .frame(height: 1)
        }
    }
    
    /// Dynamic Scrollable Tab Bar
    @ViewBuilder
    func CustomTabBar() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach($tabs) { $tab in
                    Button {
                        withAnimation(.snappy) {
                            activeTab = tab.id
                            tabBarScrollState = tab.id
                            mainViewScrollState = tab.id
                        }
                    } label: {
                        Text(tab.id.rawValue)
                            .padding(.vertical, 12)
                            .foregroundColor(activeTab == tab.id ? Color.primary : .gray)
                            .contentShape(.rect)
                    }
                    .buttonStyle(.plain)
                    .rect { rect in
                        tab.size = rect.size
                        tab.minX = rect.minX
                    }
                }
            }
        }
        // I simply set the get property beacuse I just needed to update teh scroll position
        .scrollPosition(id: .init(get: {
            return tabBarScrollState
        }, set: { _ in
            
        }))
        .overlay(alignment: .bottom, content: {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.gray.opacity(0.3))
                    .frame(height: 1)
                
                let inputRange = tabs.indices.compactMap { return CGFloat($0) }
                let outputRange = tabs.compactMap { return $0.size.width }
                let outputPositionRange = tabs.compactMap { return $0.minX }
                let indicatorWidth = progress.interpolate(inputRange: inputRange, outputRange: outputRange)
                let indicatorPosition = progress.interpolate(inputRange: inputRange, outputRange: outputPositionRange)
                
                Rectangle()
                    .fill(.primary)
                    .frame(width: indicatorWidth, height: 1.5)
                    .offset(x: indicatorPosition)
            }
        })
        .safeAreaPadding(.horizontal, 15)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    Home()
}
