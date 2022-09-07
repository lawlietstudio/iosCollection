//
//  SideMenuView.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 31/8/2022.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool
    @ObservedObject var productService = ProductService.shared
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isLinkActive = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(colorPrimary()), Color.purple]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                // Header
                SideMenuHeaderView(isShowing: $isShowing).foregroundColor(.white)
                    .frame(height: 240).padding(.bottom, -80)
                // Cell itmes
                
                NavigationLink(destination: ProductListView(categoryId: 0)){
                    SideMenuOptionView(productCategoryDto: nil, imageName: "house", title: "Home")
                }.frame(height: 48)
                
                ForEach(productService.productCategoryDtos)
                { productCategoryDto in
                    NavigationLink(destination: ProductListView(categoryId: productCategoryDto.id)){
                        SideMenuOptionView(productCategoryDto: productCategoryDto)
                    }
                }.frame(height: 48)
                
                NavigationLink(destination: ShoppingCartView()){
                    SideMenuOptionView(productCategoryDto: nil, imageName: "cart", title: "Shopping Cart")
                }.frame(height: 48)

                Spacer()
            }
        }
        .navigationBarHidden(true)
//        .onAppear(){
//            print("menu bar appear")
//        }
//        .onLoad {
//            print("menu bar onLoad")
//            self.productService.getProductCategories()
//        }
    }
}

//struct SideMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        SideMenuView(isShowing: .constant(true))
//    }
//}
