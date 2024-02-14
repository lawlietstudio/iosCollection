//
//  OnRotateView.swift
//  AllInOneReference
//
//  Created by mark on 2023-06-20.
//

import SwiftUI

struct OnRotateView: View {
    @State var ori = CustomDeviceOrientation(from: UIDevice.current.orientation)
    
    var body: some View {
        
        Text("\(ori.description)")
            .onRotate { UIDeviceOrientation in
                ori = CustomDeviceOrientation(from: UIDevice.current.orientation)
            }
            .onAppear {
                print(ori)
            }
    }
}

struct OnRotateView_Previews: PreviewProvider {
    static var previews: some View {
        OnRotateView()
    }
}
