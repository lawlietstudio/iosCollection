//
//  ProductDetailView.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 23/8/2022.
//

import SwiftUI
import CachedAsyncImage

struct ProductDetailView: View {
    let productDto: ProductDto?
    
    var body: some View {
        VStack (alignment: .leading) {
            ZStack {
                VStack {
                    Rectangle().fill(Color(UIColor(red: 81/255, green: 43/255, blue: 212/255, alpha: 1))).frame(height: 100)
                    Rectangle().fill(.white).frame(height: 100)
                }
                CachedAsyncImage(
                    url: URL(string: productDto?.imageURL ?? ""),
                    content: {image in image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 125, maxHeight: 125)},
                    placeholder: { ProgressView() }
                ).clipShape(Circle())
                    .background(Circle().fill(.white).frame(width: 150, height: 150))
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1).frame(width: 150, height: 150))
            }
            Text(productDto?.description ?? "some description").padding(15)
            Text(NSDecimalNumber(decimal: productDto?.price ?? 0).stringValue).padding(15)
//            Text(NSNumber(productDto?.qty ?? 0).stringValue)
            Spacer()
//            Button
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(productDto: nil)
    }
}
