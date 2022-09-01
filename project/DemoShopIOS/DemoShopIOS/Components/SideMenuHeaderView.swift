//
//  SideMenuHeaderView.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 31/8/2022.
//

import SwiftUI

struct SideMenuHeaderView: View {
    @Binding var isShowing: Bool
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button(action: {
                withAnimation(.spring()) {
//                    isShowing.toggle()
                    isShowing = false
                }
//                isShowing.toggle()
            }, label: {Image(systemName: "xmark")
                .frame(width: 32, height: 32)
                .foregroundColor(.white)
                .padding()
                
            })
        
            VStack(alignment: .leading) {
                Image("menuLogo").resizable().scaledToFit().clipped().frame(width: 64, height: 64).clipShape(Circle()).padding(.bottom, 16)
                
                Text("Demo Shop").font(.system(size: 24, weight: .semibold))
                Text("@Mark Ho").font(.system(size: 14)).padding(.bottom, 32)
                HStack(spacing:12) {
//                    HStack(spacing: 4) {
//                        Text("1,254").bold()
//                        Text("Following")
//                    }
//                    HStack(spacing: 4) {
//                        Text("1,254").bold()
//                        Text("Following")
//                    }
                    Spacer()
                }
                Spacer()
            }.padding()
        }
    }
}

struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuHeaderView(isShowing: .constant(true))
    }
}
