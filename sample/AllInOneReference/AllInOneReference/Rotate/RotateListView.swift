//
//  RotateListView.swift
//  AllInOneReference
//
//  Created by mark on 2023-06-16.
//

import SwiftUI

struct RotateListView: View {
    @State private var orientation = UIDevice.current.orientation
    
    var body: some View {
        NavigationView {
            VStack {
                if orientation.isLandscape {
                    HStack {
                        Image(systemName: "heart.fill")
                        Text("DevTechie")
                        Image(systemName: "heart.fill")
                    }
                    .font(.largeTitle)
                    .foregroundColor(.orange)
                } else {
                    VStack {
                        Image(systemName: "heart.fill")
                        Text("DevTechie")
                        Image(systemName: "heart.fill")
                    }
                    .font(.largeTitle)
                    .foregroundColor(.orange)
                }
                
                NavigationLink {
                    RotateDetailView()
                } label: {
                    Text("Go To Detail")
                }
            }
        }.detectOrientation($orientation)
    }
}

struct RotateListView_Previews: PreviewProvider {
    static var previews: some View {
        RotateListView()
    }
}
