//
//  ContentView.swift
//  OnBoardingAnimation
//
//  Created by mark on 2026-02-21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let image = UIImage(named: "Screen")
        let title = "Welcome to iOS 26"
        let subtitle = "Intorducing a new design with\nLiquid Glass."
        
        iOS26StyleOnBoarding(items: [
            .init(id: 0, title: title, subtitle: subtitle, screenshot: image),
            .init(id: 1, title: title, subtitle: subtitle, screenshot: UIImage(named: "Settings"), zoomScale: 1.4, zoomAnchor: .top),
            .init(id: 2, title: title, subtitle: subtitle, screenshot: UIImage(named: "Play"), zoomScale: 1.4, zoomAnchor: .topTrailing),
            .init(id: 3, title: title, subtitle: subtitle, screenshot: UIImage(named: "Highlight"), zoomScale: 1.4, zoomAnchor: .center),
            .init(id: 4, title: title, subtitle: subtitle, screenshot: image, zoomScale: 1.3, zoomAnchor: .bottom),
            .init(id: 5, title: title, subtitle: subtitle, screenshot: image, zoomScale: 1.2, zoomAnchor: .init(x: 0.5, y: -0.1)),
            .init(id: 6, title: title, subtitle: subtitle, screenshot: image),
        ])
    }
}

#Preview {
    ContentView()
}
