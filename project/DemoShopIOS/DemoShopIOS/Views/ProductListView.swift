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
    
    var body: some View {
        NavigationView {
            ZStack {
                if (isShowing)
                {
                    SideMenuView(isShowing:$isShowing)
                }
                List(productService.productDtos) { productDto in
                    NavigationLink(destination: ProductDetailView(productDto: productDto)) {
                        HStack {
                            CachedAsyncImage(
                                url: URL(string: productDto.imageURL),
                                content: {image in image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 100, maxHeight: 100)},
                                placeholder: { ProgressView() }
                            )
                            VStack(alignment: .leading) {
                                Text(productDto.name)
                                //                            Text(NSDecimalNumber(decimal: productDto.price).stringValue)
                                Text(decimal2Currency(NSDecimalNumber(decimal: productDto.price)))
                            }
                        }
                    }.disabled(isShowing)
                }
                .listStyle(PlainListStyle())
                .cornerRadius(isShowing ? 20 : 20)
                .offset(x: isShowing ? 200: 0, y: isShowing ? 24 : 0)
                .scaleEffect(isShowing ? 0.8 : 1)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading)
                    {
                        Button(action: {
                            print("go to cart")
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
                .onAppear{
                    print("onAppear")
                    isShowing = false
                    self.productService.getItems()
                    self.productService.getProductCategories()
                }
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(isShowing ? .automatic : .inline)
                if (productService.productDtos.count < 1)
                {
                    ProgressView()
                }
            }
        }
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

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
