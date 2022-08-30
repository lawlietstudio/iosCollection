//
//  SideMenuOptionView.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 31/8/2022.
//

import SwiftUI

struct SideMenuOptionView: View {
    var body: some View {
        HStack(spacing:16) {
            Image(systemName: "person")
                .frame(width: 24, height: 24)
            Text("Profile").font(.system(size: 15, weight: .semibold))
            Spacer()
        }
        .padding().foregroundColor(.white)
    }
}

struct SideMenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionView()
    }
}
