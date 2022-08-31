//
//  ProductDetailView.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 23/8/2022.
//

import SwiftUI
import CachedAsyncImage

struct ProductDetailView: View {
    let _productDto: ProductDto?
    
    init(productDto: ProductDto?) {
          UIScrollView.appearance().bounces = false
        _productDto = productDto
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            ZStack {
                VStack {
                    Rectangle().fill(Color(UIColor(red: 81/255, green: 43/255, blue: 212/255, alpha: 1))).frame(height: 100)
                    Rectangle().fill(.white).frame(height: 100)
                }
                CachedAsyncImage(
                    url: URL(string: _productDto?.imageURL ?? ""),
                    content: {image in image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 125, maxHeight: 125)},
                    placeholder: { ProgressView() }
                ).clipShape(Circle())
                    .background(Circle().fill(.white).frame(width: 150, height: 150))
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1).frame(width: 150, height: 150))
            }
            ScrollView  {
                VStack (alignment: .leading)
                {
                    Text(_productDto?.description ?? "some description")
                        
                    .padding([.leading, .trailing], 15)
                    Text(decimal2Currency(NSDecimalNumber(decimal: _productDto?.price ?? 0)))
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .padding([.leading, .trailing],15)
                        .padding([.top, .bottom],1 )
                    Text(("(\(_productDto?.qty ?? 0) items in stock)")).padding([.leading, .trailing], 15)
                }

            }.padding([.top], -15)
            Spacer()
            HStack {
                Spacer().frame(width: 20)
                Button("Add To Cart", action: {})
                    .foregroundColor(Color(UIColor(red: 81/255, green: 43/255, blue: 212/255, alpha: 1)))
                    .padding([.leading, .trailing], 15)
                    .padding([.top, .bottom], 10)
                    .frame(maxWidth: .infinity)
                    .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(UIColor(red: 81/255, green: 43/255, blue: 212/255, alpha: 1)), lineWidth: 3)
                )
                Spacer().frame(width: 20)
            }.padding(.bottom, 15)
            .navigationTitle(_productDto?.name ?? "Name")
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(productDto: nil)
    }
}
