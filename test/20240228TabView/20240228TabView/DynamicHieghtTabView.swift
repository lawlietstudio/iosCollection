//
//  DynamicHieghtTabView.swift
//  20240228TabView
//
//  Created by Mark Ho on 28/2/2024.
//

import SwiftUI

struct DynamicHieghtTabView: View {
    @State var selection: Int = 0
    @State var height: CGFloat = 300

    @State var sizeArray: [CGFloat] = [.zero, .zero, .zero]
    @State var initialHeight: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Color.red
                    .frame(height: 100)
                
                TabView(selection: $selection) {
                    Text("1\n1\n1")
                        .fixedSize()
                        .readSize(onChange: { size in
                            print(size)
                            if sizeArray[0] == size { return }
                            sizeArray[0] = size
                            if initialHeight == 0 {
                                initialHeight = size
                            }
                        })
                        .frame(height: 200)
                        .tag(0)
                    Text("2\n2\n2\n2\n2")
                        .fixedSize()
                        .readSize(onChange: { size in
                            if sizeArray[1] == size { return }
                            sizeArray[1] = size
                        })
                        .tag(1)
                    Text("3")
                        .fixedSize()
                        .readSize(onChange: { size in
                            if sizeArray[2] == size { return }
                            sizeArray[2] = size
                        })
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .background(Color.white)
                .frame(height: height)
                .onChange(of: selection) { newValue in
//                    withAnimation {
                        height = sizeArray[newValue]
//                    }
                }
//                .animation(.default, value: height)
//                .onChange(of: initialHeight) { newValue in
//                    height = newValue
//                }
            }
        }
        .background(Color.green)
    }
}

extension View {
    func readSize(onChange: @escaping (CGFloat) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size.height)
//                    .task {
//                        onChange(geometryProxy.size.height)
//                    }
            }
        )
//            .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

struct SizePreferenceKey: PreferenceKey {
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
    
  static var defaultValue: CGFloat = .zero
}

#Preview {
    DynamicHieghtTabView()
}
