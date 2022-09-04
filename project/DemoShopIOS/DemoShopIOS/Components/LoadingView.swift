//
//  Loading.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 4/9/2022.
//

import SwiftUI

struct LoadingView: View {
    @State var show = false
    @State var isInit = false
    
    var body: some View {
        ZStack {
            Color(colorDark()).opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            ProgressView()
            //            HStack {
                            
//            ZStack {
//                Text("LOADING")
//                    .foregroundColor(Color(colorDark()).opacity(0.7))
//                    .font(.system(size: 40))
//
//                Text("LOADING")
//                    .foregroundColor(Color(colorDark()))
//                    .font(.system(size: 40))
//                    .mask {
//                        Capsule()
//                            .fill(LinearGradient(gradient: Gradient(colors: [.clear,.white,.clear]), startPoint: .top, endPoint: .bottom))
//                            .rotationEffect(.init(degrees: 45))
//                            .offset(x: self.show ? 100 : -100)
//                    }
//            }
        }
//        .onLoad {
//            if (!isInit)
//            {
//                withAnimation(Animation.default.speed(0.2).delay(0).repeatForever(autoreverses: false))
//                {
//                    self.show.toggle()
//                }
//            }
//            isInit = true
//        }
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
