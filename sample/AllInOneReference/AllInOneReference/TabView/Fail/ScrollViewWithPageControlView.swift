//
//  ScrollViewWithPageControlView.swift
//  AllInOneReference
//
//  Created by mark on 2023-05-26.
//

import SwiftUI

struct ScrollViewWithPageControlView: View {
    @State private var currentPage = 0
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .blue
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                HStack(spacing: 20) {
                    ForEach(0..<5) { index in
                        Text("Page \(index + 1)")
//                            .frame(width: UIScreen.main.bounds.width)
                    }
                }
                .onAppear {
//                    UIScrollView.appearance().bounces = false
                }
                .frame(height: UIScreen.main.bounds.height * 0.8)
                .offset(x: UIScreen.main.bounds.width * CGFloat(currentPage), y: 0)
//                .frame(width: UIScreen.main.bounds.width)
//                .pagingEnabled(true)
                .scrollDisabled(false)
//                .indicatorStyle(.black)
//                .onChange(of: currentPage) { value in
//                    UIScrollView.appearance().setContentOffset(CGPoint(x: UIScreen.main.bounds.width * CGFloat(value), y: 0), animated: true)
//                }
//                .onReceive(NotificationCenter.default.publisher(for: UIScrollView.didScrollNotification)) { _ in
////                                    guard let scrollView = scrollViewProxy.scrollView else { return }
////                                    offset = scrollView.contentOffset.y
//                                }
            }
            
            PageControl(numberOfPages: 5, currentPage: $currentPage)
        }
    }
}

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = currentPage
        pageControl.addTarget(context.coordinator, action: #selector(Coordinator.updateCurrentPage(sender:)), for: .valueChanged)
        return pageControl
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: PageControl
        
        init(_ parent: PageControl) {
            self.parent = parent
        }
        
        @objc func updateCurrentPage(sender: UIPageControl) {
            parent.currentPage = sender.currentPage
        }
    }
}

