//
//  ProductListView.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 23/8/2022.
//

import SwiftUI
import CachedAsyncImage

struct ProductListView: View {
    @State private var isShowing = false;
    @ObservedObject var productService = ProductService.shared
    var categoryId : Int
    
    var body: some View {
        NavigationView {
            ZStack {
                if (isShowing)
                {
                    SideMenuView(isShowing:$isShowing)
                }
                List(productService.productDtos) { productDto in
                    ZStack {
                        Color.white.opacity(0.3)
                            .frame(maxWidth: .infinity, maxHeight:. infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 0)
                        
                        NavigationLink(destination: ProductDetailView(productDto: productDto)) {
                            HStack {
                                CachedAsyncImage(
                                    url: URL(string: productDto.imageURL),
                                    content: {image in image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 80)},
                                    placeholder: { ProgressView() }
                                )
                                VStack(alignment: .leading) {
                                    Text(productDto.name)
                                    //                            Text(NSDecimalNumber(decimal: productDto.price).stringValue)
                                    Text(decimal2Currency(NSDecimalNumber(decimal: productDto.price)))
                                }
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.leading, 8)
                        }
                        .listRowInsets(.init(top: 0, leading: 4, bottom: 0, trailing: 4))
                        .disabled(isShowing)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.1 )), lineWidth: 1)
                        )
                        
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
//                    .seperator
                }.padding([.top, .bottom], -24)
                //                .if(isShowing) { $0.listStyle(InsetListStyle()) }
                //                .if(!isShowing) { $0.listStyle(PlainListStyle()) }
                    .listStyle(SidebarListStyle())
                    .cornerRadius(isShowing ? 20 : 0)
                    .offset(x: isShowing ? 200: 0, y: isShowing ? 24 : 0)
                    .scaleEffect(isShowing ? 0.8 : 1)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading)
                        {
                            Button(action: {
                                withAnimation(.spring()) {
                                    isShowing.toggle()
                                }
                                
                            },
                                   //                           "list.bullet"
                                   label: {Image(systemName: "text.justify")
                                    .font(.system(size: 14))
                                .foregroundColor(.white)})
                            
                        }
                    }
                    .onLoad {
                        print("list view onLoad")
                        if (categoryId == 0) // get all
                        {
                            self.productService.getItems()
                        }
                        else
                        {
                            self.productService.getItemByCategory(categoryId: categoryId)
                        }
                        self.productService.getProductCategories()
                    }
                    .onAppear{
                        print("onAppear")
                        isShowing = false
                    }
                    .navigationTitle(getCategoryNameById(id: categoryId, productCategoryDtos: self.productService.productCategoryDtos))
                    .navigationBarTitleDisplayMode(isShowing ? .automatic : .inline)
                if (productService.productDtos.count < 1)
                {
                    ProgressView()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = colorPrimary()
            appearance.titleTextAttributes = [.foregroundColor: UIColor(Color.white)]
            
            UINavigationBar.appearance().tintColor = .white
            // Inline appearance (standard height appearance)
            UINavigationBar.appearance().standardAppearance = appearance
            // Large Title appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        .statusBarStyle(.lightContent) //set status bar style here
    }
}

func getCategoryNameById(id : Int, productCategoryDtos : [ProductCategoryDto]) -> String
{
    for productCategoryDto in productCategoryDtos
    {
        if (productCategoryDto.id == id)
        {
            return productCategoryDto.name
        }
    }
    return "Home"
}

//struct ProductListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductListView()
//    }
//}
