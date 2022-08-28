//
//  ProductListView.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 23/8/2022.
//

import SwiftUI
import CachedAsyncImage

struct ProductListView: View {
    @ObservedObject var productService = ProductService()
    
    var body: some View {
        NavigationView {
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
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading)
                {
                    Button(action: {
                        print("go to cart")
                    },
                           label: {Image(systemName: "text.justify")
                        .font(.body)
                        .foregroundColor(.white)})
                    
                }
            }
        }
        .onAppear {
            print("onAppear")
            self.productService.getItems()
            let appearance = UINavigationBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(red: 81/255, green: 43/255, blue: 212/255, alpha: 1)
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
