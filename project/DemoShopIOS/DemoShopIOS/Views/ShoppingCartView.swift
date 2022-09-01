//
//  ShoppingCartView.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 1/9/2022.
//

import SwiftUI
import CachedAsyncImage

struct ShoppingCartView: View {
    @State private var isShowing = false;
    @ObservedObject var shoppingCartService = ShoppingCartService.shared
    
    var body: some View {
        NavigationView {
            ZStack {
                if (isShowing)
                {
                    SideMenuView(isShowing:$isShowing)
                }
                List(shoppingCartService.cartItemDtos) { cartItemDto in
                    VStack {
                        HStack {
                            Spacer().frame(width: 20)
                            CachedAsyncImage(
                                url: URL(string: cartItemDto.productImageURL),
                                content: {image in image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 100, maxHeight: 100)},
                                placeholder: { ProgressView() }
                            )
                            Spacer()
                            VStack(alignment: .leading) {
                                Text(cartItemDto.productName)
                                Text("Price: " + decimal2Currency(NSDecimalNumber(decimal: cartItemDto.price)))
                                Text("Qty: \(cartItemDto.qty)")
                            }
                            Spacer()
                        }
                        HStack {
                            Spacer().frame(width: 20)
                            Button(action: { shoppingCartService.deleteItem(id: cartItemDto.id ) })
                            {Text("Add to Cart")}
                                .buttonStyle(CommonButtonStyle(color: Color(colorDanger())))
                            Spacer().frame(width: 20)
                        }.padding(.bottom, 15)
                    }
                    
                    .listRowBackground(Color.clear)
                }.disabled(isShowing)
                 .animation(Animation.easeOut(duration: 1))
                
                
                
                
                //                .if(isShowing) { $0.listStyle(InsetListStyle()) }
                //                .if(!isShowing) { $0.listStyle(PlainListStyle()) }
                    .listStyle(InsetListStyle())
                    .cornerRadius(isShowing ? 20 : 20)
                    .offset(x: isShowing ? 200: 0, y: isShowing ? 24 : 0)
                    .scaleEffect(isShowing ? 0.8 : 1)
                
                //                Button(action: {isShowing.toggle(); print(isShowing)}) {
                //                    Text("Shopping Cart")
                ////                        .cornerRadius(isShowing ? 20 : 20)
                //                        .offset(x: isShowing ? 200: 0, y: isShowing ? 24 : 0)
                //                    .scaleEffect(isShowing ? 0.8 : 1)
                //                }
                
                if (shoppingCartService.cartItemDtos.count < 1)
                {
                    ProgressView()
                }
            }
            .onAppear{
                shoppingCartService.getItems(userId: Constants.userId)
            }
            .navigationTitle("Shopping Cart")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(isShowing)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading)
                {
                    Button(action: {
                        print("go to cart")
                        withAnimation(.spring()) {
                            isShowing.toggle()
                            
                        }
                        print($isShowing)
                    },
                           //                           "list.bullet"
                           label: {Image(systemName: "text.justify")
                            .font(.system(size: 14))
                        .foregroundColor(.white)})
                    
                }
            }
        }
        .navigationBarHidden(true)
    }
}

//struct ShoppingCartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingCartView()
//    }
//}
