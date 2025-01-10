//
//  Home.swift
//  ResponsiveUIDesign
//
//  Created by mark on 2025-01-06.
//

import SwiftUI
// MARK: iOS 16+
import Charts

struct Home: View {
    var props: Properties
    // MARK: View Properties
    @State var currentTab: String = "Home"
    @Namespace var animation
    @State var showSideBar: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            if props.isAdoptable {
                ViewThatFits {
                    ScrollView(.vertical, showsIndicators: false) {
                        SideBar()
                    }
                    .background {
                        Color(.cardBackground).ignoresSafeArea()
                    }
                }
                .onAppear {
                    withAnimation {
                        showSideBar = false
                    }
                }
            }

            ScrollView(.vertical, showsIndicators: false)
            {
                VStack {
                    HeaderView()
                    
                    InfoCards()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            DailySalesView()
                            
                            PieChartView()
                        }
                    }
                    
                    TrendingItemsView()
                }
                .safeAreaPadding(15)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background {
            Color.reversedSystem
                .opacity(0.04)
                .ignoresSafeArea()
        }
        .overlay(alignment: .leading) {
            // MARK: Side Bar For Non iPad Devices
            ViewThatFits {
                ScrollView(.vertical, showsIndicators: false) {
                    SideBar()
                }
                .background {
                    Color(.cardBackground).ignoresSafeArea()
                }
            }
            .offset(x: showSideBar ? 0 : -100)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                Color.reversedSystem
                    .opacity(showSideBar ? 0.25 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showSideBar.toggle()
                        }
                    }
            }
        }
    }
    
    // MARK: Trending Items View
    @ViewBuilder
    func TrendingItemsView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Trending Dishes")
                .font(.title3.bold())
                .padding(.bottom)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: props.isAdoptable ? 2 : 1), spacing: props.isAdoptable ? 20 : 15) {
                ForEach(trendingDishes) {
                    item in
                    HStack(spacing: 15) {
                        Image(item.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                            .padding(10)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.orange.opacity(0.1))
                                    .lineLimit(1)
                            }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.title)
                                .fontWeight(.bold)
                                .lineLimit(2)
                            
                            Label {
                                Text(item.title)
                                    .foregroundStyle(.orange)
                            } icon: {
                                Text("\(item.subTitle):")
                                    .foregroundStyle(.gray)
                            }
                            .font(.callout)
                            .fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .topTrailing, content: {
            Button("View All") {
                
            }
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundStyle(.orange)
            .offset(y: 6)
        })
        .padding(15)
        .cardBackground()
        .padding(.top, 10)
    }
    
    // MARK: PieChart View
    @ViewBuilder
    func PieChartView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Total Income")
                .font(.title3.bold())
            
            ZStack {
                Circle()
                    .trim(from: 0.5, to: 1)
                    .stroke(.red, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                
                Circle()
                    .trim(from: 0.2, to: 0.5)
                    .stroke(.yellow, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                
                Circle()
                    .trim(from: 0, to: 0.2)
                    .stroke(.green, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                
                Text("$200K")
                    .font(.title)
                    .fontWeight(.heavy)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack(spacing: 15) {
                Label {
                    Text("Food")
                        .font(.caption)
                        .foregroundStyle(.reversedSystem)
                } icon: {
                    Image(systemName: "circle.fill")
                        .font(.caption2)
                        .foregroundStyle(.green)
                }
                
                Label {
                    Text("Drink")
                        .font(.caption)
                        .foregroundStyle(.reversedSystem)
                } icon: {
                    Image(systemName: "circle.fill")
                        .font(.caption2)
                        .foregroundStyle(.red)
                }
                
                Label {
                    Text("Others")
                        .font(.caption)
                        .foregroundStyle(.reversedSystem)
                } icon: {
                    Image(systemName: "circle.fill")
                        .font(.caption2)
                        .foregroundStyle(.yellow)
                }
            }
        }
        .padding(15)
        .frame(width: 250, height: 250)
        .cardBackground()
    }
    
    // MARK: Graph View
    @ViewBuilder
    func DailySalesView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Daily Sales")
                .font(.title3.bold())
            
            Chart {
                ForEach(dailySales) {
                    sale in
                    // MARK: Area Mark
                    AreaMark(
                        x: .value("Time", sale.time),
                        y: .value("Sale", sale.sales)
                    )
                    .foregroundStyle(.linearGradient(colors: [
                        .orange.opacity(0.6),
                        .orange.opacity(0.5),
                        .orange.opacity(0.3),
                        .orange.opacity(0.1),
                        .clear
                    ], startPoint: .top, endPoint: .bottom))
                    .interpolationMethod(.catmullRom)
                    
                    // MARK: Line Mark
                    LineMark(
                        x: .value("Time", sale.time),
                        y: .value("Sale", sale.sales)
                    )
                    .foregroundStyle(.orange)
                    .interpolationMethod(.catmullRom)
                    
                    // MARK: Point Mark For Showing Points
                    PointMark(
                        x: .value("Time", sale.time),
                        y: .value("Sale", sale.sales)
                    )
                    .foregroundStyle(.orange)
                }
            }
            .frame(height: 180)
        }
        .padding(15)
        .cardBackground()
        // MARK: 400 -> side bar(100) + padding(30) + piechartview(250) + spacing(20)
        .frame(minWidth: props.isAdoptable ? props.size.width - 400 : props.size.width - 30)
    }
    
    // MARK: Info Cards View
    @ViewBuilder
    func InfoCards() -> some View {
        ScrollView(.horizontal, showsIndicators: false)
        {
            HStack(spacing: 10) {
                ForEach(infos) { info in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 15) {
                            Text(info.title)
                                .font(.title3.bold())
                            
                            Spacer()
                            
                            HStack(spacing: 8) {
                                Image(systemName: info.loss ? "arrow.down" : "arrow.up")
                                Text("\(info.percentage)%")
                            }
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(info.loss ? .red : .green)
                        }
                        
                        HStack(spacing: 18) {
                            Image(systemName: info.icon)
                                .font(.title2)
                                .foregroundStyle(.cardBackground)
                                .frame(width: 45, height: 45)
                                .background {
                                    Circle()
                                        .fill(info.iconColor)
                                }
                            
                            Text(info.amount)
                                .font(.title.bold())
                        }
                    }
                    .padding()
                    .cardBackground()
                }
            }
            .padding(.vertical, 15)
        }
    }
    
    // MARK: Header View
    @ViewBuilder
    func HeaderView() -> some View {
        // Mark: Dynamic Layout(iOS 16+)
        let layout = props.isIPad && !props.isMaxSplit ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout(spacing: 22))
        
        layout {
            VStack(alignment: .leading, spacing: 8) {
                Text("Seattle, New York")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // MARK: Search Bar With Menu Button
            HStack(spacing: 10) {
                if !props.isAdoptable {
                    Button {
                        withAnimation {
                            showSideBar = true
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(.reversedSystem)
                    }
                }
                
                TextField("Search", text: .constant(""))
                
                Image(systemName: "magnifyingglass")
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                Capsule()
                    .fill(.cardBackground)
                    .shadow(color: .reversedSystem.opacity(0.05), radius: 8, x: 0, y: 2)
            }
        }
    }
    
    // MARK: Side Bar
    @ViewBuilder
    func SideBar() -> some View {
        // MARK: Tabs
        let tabs: [(String, String)] = [
            ("Home", "house.fill"), ("Table", "tablecells.fill"), ("Menu", "menucard.fill"), ("Order", "cart.fill"), ("History", "clock.fill"), ("Report", "chart.pie.fill"), ("Alert", "bell.fill"), ("Settings", "gearshape.fill")
        ]
        
        VStack(spacing: 10) {
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 55, height: 55)
                .clipShape(.circle)
                .padding(.bottom, 10)
            
            ForEach(tabs, id: \.self.0) { tab in
                VStack(spacing: 8) {
                    Image(systemName: tab.1)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                    
                    Text(tab.0)
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(currentTab == tab.0 ? .orange : .gray)
                .padding(.vertical, 13)
                .frame(width: 65)
                .background {
                    if currentTab == tab.0 {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.orange.opacity(0.1))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        currentTab = tab.0
                    }
                }
            }
            
            Button {
                
            } label: {
                VStack {
                    Image("Pic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45, height: 45)
                        .clipShape(.circle)
                    
                    Text("Profile")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                }
            }
            .padding(.top, 20)
        }
        .padding(.vertical)
        .frame(maxHeight: .infinity, alignment: .top)
        .frame(width: 100)
        .background {
            Color.cardBackground
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
