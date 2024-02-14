//
//  RotateDetailView.swift
//  AllInOneReference
//
//  Created by mark on 2023-06-16.
//

import SwiftUI

struct RotateDetailView: View {
    @State private var orientation = UIDevice.current.orientation
    
    var body: some View {
        Text("\(String(orientation.isLandscape))")
            .detectOrientation($orientation)
    }
}

//#Preview {
//    RotateDetailView()
//}
