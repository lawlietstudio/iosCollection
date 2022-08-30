//
//  SideMenuView.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 31/8/2022.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
//            background(.blue)
            LinearGradient(gradient: Gradient(colors: [Color(colorPrimary())]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                // Header
                SideMenuHeaderView(isShowing: $isShowing).foregroundColor(.white)
                    .frame(height: 240).padding(.bottom, -80)
                // Cell itmes
                ForEach(0..<6) { _ in
                    SideMenuOptionView()
                }
                
                Spacer()
            }
        }.navigationBarHidden(true)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowing: .constant(true))
    }
}
