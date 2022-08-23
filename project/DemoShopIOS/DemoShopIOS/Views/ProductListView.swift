//
//  ProductListView.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 23/8/2022.
//

import SwiftUI

struct ProductListView: View {
    @ObservedObject var productService = ProductService()
    
    var body: some View {
        NavigationView {
            List(productService.productDtos) { productDto in
                NavigationLink(destination: ProductDetailView(productDto: productDto)) {
                    HStack {
                        AsyncImage(
                            url: URL(string: productDto.imageURL),
                            content: {image in image.resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(maxWidth: 100, maxHeight: 100)},
                            placeholder: { ProgressView() }
                        )
                        VStack(alignment: .leading) {
                            Text(productDto.name)
                            Text(NSDecimalNumber(decimal: productDto.price).stringValue)
                        }
                    }
                }
            }
            .navigationTitle("Home")
        }
        .onAppear {
            self.productService.getItems()
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
