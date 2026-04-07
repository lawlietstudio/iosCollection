//
//  TestingView.swift
//  SkeletonLoadingAnimation
//
//  Created by mark on 2025-04-15.
//

import SwiftUI

struct TestingView: View {
    var body: some View {
        VStack {
            Text("Loading title")
            Text("This should show")
                .unredacted()
        }
        .redacted(reason: [.placeholder, .privacy])

    }
}

#Preview {
    TestingView()
}
