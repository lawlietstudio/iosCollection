//
//  ScrollViewWithPageControlTwo.swift
//  AllInOneReference
//
//  Created by mark on 2023-05-27.
//

import SwiftUI

struct ScrollViewWithPageControlTwo: View {
    @State private var currentPage = 0
    @State private var offset = 0.0
    
    @GestureState var goffset: CGFloat = UIScreen.main.bounds.width / 2
    
    var body: some View {
        VStack {
//            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    Color.red.frame(width: UIScreen.main.bounds.width)
                    Color.blue.frame(width: UIScreen.main.bounds.width)
                }
                .offset(x: goffset)
//                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            print("onChanged")
//                            offset = goffset
//                            print(value)
                        })
                        .updating($goffset, body: { value, out, transaction in
                            print("updating")
                            print(value)
                            print(out)
                            out = value.translation.width
                        })
                        .onEnded { value in
                            print("onEnded")
                            print(value)
//                        offset = value.translation.width
//                            offset = goffset
//                        print(offset)
                        let screenWidth = UIScreen.main.bounds.width
                        let threshold: CGFloat = 50
                        let newIndex = offset > threshold ? currentPage - 1 : (offset < -threshold ? currentPage + 1 : currentPage)
                        currentPage = min(max(newIndex, 0), 1)
                            print(currentPage)
                    }
                )
                .animation(.easeInOut, value: goffset == 0)
//            }
            
            Text("\(goffset)")
            TabView(selection: $currentPage) {
                Text("Page 1")
                    .tag(0)
                Text("Page 2")
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

