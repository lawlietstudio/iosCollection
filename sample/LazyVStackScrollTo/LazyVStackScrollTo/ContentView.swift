//
//  ContentView.swift
//  LazyVStackScrollTo
//
//  Created by mark on 2023-04-15.
//

import SwiftUI

struct ContentView: View {
    @State var scrollIndex:any Hashable = 0
    let colors: [Color] = [.red, .green, .blue]
//    @State var proxy: ScrollViewProxy
    let itemCount = 50
    @State private var newScrollViewProxy: (ScrollViewProxy)? = nil
    
    var body: some View {
        VStack {
                    Button("Scroll to top") {
                        // Scroll to the top of the list
                        withAnimation {
                            self.newScrollViewProxy?.scrollTo(0)
                        }
                    }
                    ScrollViewReader { scrollViewProxy in
                        
//                            self.newScrollViewProxy = (scrollViewProxy)
                        ScrollView {
                            LazyVStack {
                                    ForEach(0..<100) { index in
                                        Text("Row \(index)")
                                            .padding()
                                            .id(index)
                                    }
                                }
//                                LazyVStack(spacing: 10) {
//                                    ForEach(0..<itemCount) { index in
//                                        Text("Item \(index)")
//                                            .frame(width: 200, height: 50)
//                                            .background(Color.gray.opacity(0.2))
//                                            .id(index)
//                                    }
//                                }
                                .padding()
                            }
                            .onAppear {
                                self.newScrollViewProxy = (scrollViewProxy)
                                // Scroll to the bottom of the list when the view appears
                                withAnimation {
                                    scrollViewProxy.scrollTo(25)
                                }
                            }
                        
                    }
                }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
