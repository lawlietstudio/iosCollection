//
//  ShoppingCartView.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 1/9/2022.
//

import SwiftUI

struct ShoppingCartView: View {
    @State private var isShowing = false;
    
    var body: some View {
        NavigationView {
            ZStack {
                if (isShowing)
                {
                    SideMenuView(isShowing:$isShowing)
                }
                Button(action: {isShowing.toggle(); print(isShowing)}) {
                    Text("Shopping Cart")
                        .cornerRadius(isShowing ? 20 : 20)
                        .offset(x: isShowing ? 200: 0, y: isShowing ? 24 : 0)
                    .scaleEffect(isShowing ? 0.8 : 1)
                }
            }
            .navigationTitle("Shopping Cart")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(isShowing)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading)
                {
                    Button(action: {
                        print("go to cart")
                        withAnimation(.spring()) {
                            isShowing.toggle()
                            
                        }
                        print($isShowing)
                    },
                           //                           "list.bullet"
                           label: {Image(systemName: "text.justify")
                            .font(.system(size: 14))
                        .foregroundColor(.white)})
                    
                }
            }
        }
        .navigationBarHidden(true)
    }
}

//struct ShoppingCartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingCartView()
//    }
//}
