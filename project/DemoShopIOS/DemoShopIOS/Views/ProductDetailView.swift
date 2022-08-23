//
//  ProductDetailView.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 23/8/2022.
//

import SwiftUI

struct ProductDetailView: View {
    let productDto: ProductDto?
    
    var body: some View {
        VStack (alignment: .leading) {
            Rectangle().frame(height: 100)
            
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
