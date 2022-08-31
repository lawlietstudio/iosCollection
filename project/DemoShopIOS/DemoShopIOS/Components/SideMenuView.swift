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
                NavigationLink(
                    destination: ProductListView(),
                    label: { SideMenuOptionView(productCategoryDto: nil)
                    }
                )
                ForEach(productService.productCategoryDtos)
                { productCategoryDto in
                    Button(action: {}, label: {
                        { SideMenuOptionView(productCategoryDto: productCategoryDto)
                    })
//                    NavigationLink(
//                        destination: Text(productCategoryDto.name),
//                        label:
//                        }
//                    )
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

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowing: .constant(true))
    }
}
