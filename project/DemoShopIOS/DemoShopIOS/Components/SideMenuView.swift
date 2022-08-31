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
//            background(.blue)
            LinearGradient(gradient: Gradient(colors: [Color(colorPrimary())]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                // Header
                SideMenuHeaderView(isShowing: $isShowing).foregroundColor(.white)
                    .frame(height: 240).padding(.bottom, -80)
                // Cell itmes
//                ForEach(0..<6) { _ in
//                    SideMenuOptionView()
//                }
                
//                ForEach(SideMenuViewModel.allCases, id: \.self)
//                { option in
//                    NavigationLink(
//                        destination: Text(option.title),
//                        label: { SideMenuOptionView(viewModel: option)
//                        }
//                    )
//
//                }
                
//                NavigationLink(
//                    destination: ProductListView(),
//                    label: { SideMenuOptionView(productCategoryDto: nil)
//                    }
//                )
                
//                Button(action: {
//                        withAnimation(.spring()) {
//                            isShowing.toggle()
//                        }
//                        self.presentationMode.wrappedValue.dismiss()
//                    }, label:
//                    {
//                        SideMenuOptionView(productCategoryDto: nil, imageName: "house", title: "Home")
//                    }
//                )
                
                NavigationLink(destination: ProductListView()){
                    SideMenuOptionView(productCategoryDto: nil, imageName: "house", title: "Home")
                }
                
                ForEach(productService.productCategoryDtos)
                { productCategoryDto in
                    Button(action: {
                            withAnimation(.spring()) {
                                isShowing.toggle()
                            }
                        }, label:
                        {
                        SideMenuOptionView(productCategoryDto: productCategoryDto)
                        }
                    )
                }
                
                NavigationLink(destination: ShoppingCartView()){
                    SideMenuOptionView(productCategoryDto: nil, imageName: "cart", title: "Shopping Cart")
                }

                Spacer()
            }
        }
        .navigationBarHidden(true)
        .onAppear(){
            print("menu bar appear")
        }
        .onLoad {
            print("menu bar onLoad")
            self.productService.getProductCategories()
        }
    }
}

//struct SideMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        SideMenuView(isShowing: .constant(true))
//    }
//}
