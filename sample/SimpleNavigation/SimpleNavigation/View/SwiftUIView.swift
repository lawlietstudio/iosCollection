//
//  SwiftUIView.swift
//  SimpleNavigation
//
//  Created by mark on 2023-04-14.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var showModal = false
    
    @State private var count = 0
    private var nonUICount = 0
    
    var incrementedCount: Int {
        count + 1
    }
    
    init() {
        /*
        "Modifying state during view update, this will cause undefined behavior."

       This is because SwiftUI manages the lifecycle of views and their associated state, and expects all updates to state to be done through specific update methods like onAppear() or onTapGesture(). Attempting to modify state directly during initialization breaks this lifecycle and can lead to unexpected behavior.
        */
        performIncrease()
        nonUICount += 3
        print("nonUICount: \(nonUICount)")
    }
    
    func performIncrease()
    {
        count += 1
        print("count: \(count)")
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                NavigationLink(destination: SecondSwiftUIView())
                {
                    Text("SwiftUI View")
                }
                
                NavigationLink(destination: StoryboardWrapper()) {
                    Text("Go to storyboard")
                }
                
                Button(action: {
                    self.showModal = true
                }) {
                    Text("Navigation Like Modal")
                }
                .fullScreenCover(isPresented: $showModal) {
                    XIBWrapper()
                }
                
                Button(action: {}, label: {
                    Text("Navigation Like Modal")
                })
                
//                Button("Navigation Like Modal") {
//                    self.showModal = true
//                }
//                .sheet(isPresented: $showModal) {
//                    XIBWrapper()
//                }
                
                Text("\(incrementedCount)")
            }
            .onAppear()
            {
//                performIncrease()
//                count += 1
            }
        }
    }
}

struct StoryboardWrapper: UIViewControllerRepresentable
{
    func makeUIViewController(context: Context) -> some UIViewController {
        let otherStoryboard = UIStoryboard(name: "SecondStoryboard", bundle: nil)
        return otherStoryboard.instantiateInitialViewController()!
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        print("updateUIViewController")
    }
}

struct XIBWrapper: UIViewControllerRepresentable
{
    func makeUIViewController(context: Context) -> some UIViewController {
        return XIBViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
