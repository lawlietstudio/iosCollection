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
    @State var isLinkActive = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(productDto: ProductDto?) {
          UIScrollView.appearance().bounces = false
        _productDto = productDto
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.secondarySystemBackground).ignoresSafeArea()
            VStack (alignment: .leading) {
                ZStack {
    //                Color(UIColor.secondarySystemBackground).ignoresSafeArea()
                    VStack {
                        Rectangle().fill(Color(colorPrimary())).frame(height: 100)
                        Rectangle().fill(.clear).frame(height: 100)
                    }
                    ZStack {
                        Color.white.opacity(0.3)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .shadow(color: Color(colorDark()).opacity(0.3), radius: 4, x: 0, y: 0)
                        CachedAsyncImage(
                            url: URL(string: _productDto?.imageURL ?? ""),
                            content: {image in image.resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(maxWidth: 125, maxHeight: 125)},
                            placeholder: { ProgressView() }
                        )
                        .clipShape(Circle())
                        .background(Circle().fill(Color(UIColor.secondarySystemBackground)).frame(width: 150, height: 150))
                        .overlay(Circle().stroke(Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.1 )), lineWidth: 1).frame(width: 150, height: 150))
                    }
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
                    .foregroundColor(Color(colorDark()))
                    .shadow(color: Color(colorDark()).opacity(0.3), radius: 4, x: 0, y: 0)
                }
                .padding([.top], -15)
                Spacer()
                HStack {
                    Spacer().frame(width: 20)
    //                CommonButton(text: "Add to Cart")
                    Button(action: {
                        print ("add to cart")
                        NavigationUtil.goToView()
//                        self.isLinkActive = true
                    })
                    {
                        Text("Add to Cart")
                        
                    }
                    .buttonStyle(CommonButtonStyle())
                    NavigationLink(destination: ShoppingCartView(), isActive: $isLinkActive) {
                        EmptyView()
                    }
                    .hidden()
                    Spacer().frame(width: 20)
                }
                .padding(.bottom, 15)
                .navigationTitle(_productDto?.name ?? "Name")
            }
        }
        .onAppear()
        {
            isLinkActive = false
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(productDto: nil)
    }
}
