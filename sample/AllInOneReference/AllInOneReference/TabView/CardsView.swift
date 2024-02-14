//
//  CardsView.swift
//  AllInOneReference
//
//  Created by mark on 2023-05-26.
//

import SwiftUI

struct CardsView: View {
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .blue
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
        
        let appearance = UITabBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundImage = UIImage()
                appearance.shadowImage = UIImage()
                UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
//        VStack {
//            Text("This long text string is clipped")
//                .fixedSize()
//                .frame(width: 175, height: 100)
////                .clipped()
//                .border(Color.gray)
            
                TabView {
                    GeometryReader { geometry in
                                    Text("Tab 1")
                                        .frame(width: geometry.size.width, height: geometry.size.height)
                                }
                                .tag(1)
                                .tabItem {
                                    Label("Tab 1", systemImage: "1.circle")
                                }
                                
                                GeometryReader { geometry in
                                    Text("Tab 2")
                                        .frame(width: geometry.size.width, height: geometry.size.height)
                                }
                                .tag(2)
                                .tabItem {
                                    Label("Tab 2", systemImage: "2.circle")
                                }
                }
                .tabViewStyle(PageTabViewStyle())
                
                .frame(width: UIScreen.main.bounds.size.width / 2, height: 450)
//                .onAppear {
////                  setupAppearance()
//                }
//        }
//        .padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24))
//        .frame(height: 450)
    }
    
    func setupAppearance() {
      UIPageControl.appearance().currentPageIndicatorTintColor = .black
      UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}

struct CardView: View {
    
    var body: some View {
        HStack {
            Text("Testing")
            Spacer()
        }
        .background(.red)
        .frame(width: 100)
//        GeometryReader { geometry in
//            Group {
//                VStack {
//                    HStack {
//                        Text("Testing")
//                        Spacer()
//                    }
//                    Spacer()
//                }
//                .padding()
//                .background(.red)
//                .cornerRadius(5)
//            }
//            .frame(width: 100)
//            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//        }
    }
}
