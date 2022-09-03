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
                Color(UIColor.secondarySystemBackground).ignoresSafeArea()
                if (isShowing)
                {
                    SideMenuView(isShowing:$isShowing)
                }
                VStack {
                    List($shoppingCartService.cartItemDtos) { $cartItemDto in
                        ZStack {
                            Color.white.opacity(0.3)
                                .frame(maxWidth: .infinity, maxHeight:. infinity)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadow(color: Color(colorDark()).opacity(0.3), radius: 4, x: 0, y: 0)
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Spacer().frame(width: 20)
                                    CachedAsyncImage(
                                        url: URL(string: cartItemDto.productImageURL),
                                        content: {image in image.resizable()
                                                .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 100, maxHeight: 100)},
                                        placeholder: { ProgressView() }
                                    )
                                    //                                Spacer()
                                    VStack(alignment: .leading) {
                                        Text(cartItemDto.productName)
                                        Text("Price: " + decimal2Currency(NSDecimalNumber(decimal: cartItemDto.price)))
                                        Text("Qty: \(cartItemDto.qty)")
                                    }
                                    Spacer()
                                }
                                HStack {
                                    Spacer().frame(width: 20)
                                    Button(action: { cartItemDto.qty -= 1 })
                                    {Text("- 1")}
                                        .buttonStyle(CommonButtonStyle())
                                    Spacer().frame(width: 20)
                                    Button(action: { cartItemDto.qty += 1 })
                                    {Text("+ 1")}
                                        .buttonStyle(CommonButtonStyle())
                                    Spacer().frame(width: 20)
                                    Button(action: {  })
                                    {Text("Update")}
                                        .buttonStyle(CommonButtonStyle())
                                    Spacer().frame(width: 20)
                                }
                                HStack {
                                    Spacer().frame(width: 20)
                                    Button(action: { shoppingCartService.deleteItem(id: cartItemDto.id ) })
                                    {Text("Remove")}
                                        .buttonStyle(CommonButtonStyle(color: Color(colorDanger())))
                                    Spacer().frame(width: 20)
                                }
                                //                            .padding(.bottom, 15)
                            }
                            .padding(8)
                            .padding([.top, .bottom], 16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.1 )), lineWidth: 1)
                            )
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .padding([.top, .bottom], -24)
                    .padding(.leading, -8)
                    .disabled(isShowing)
                    
                    //                 .animation(Animation.easeOut(duration: 1))
                    
                    
                    
                    
                    //                .if(isShowing) { $0.listStyle(InsetListStyle()) }
                    //                .if(!isShowing) { $0.listStyle(PlainListStyle()) }
                    .listStyle(SidebarListStyle())
                    .cornerRadius(isShowing ? 20 : 0)
                    .offset(x: isShowing ? 200: 0, y: isShowing ? 24 : 0)
                    .scaleEffect(isShowing ? 0.8 : 1)
                    if (!isShowing)
                    {
                        ZStack {
                            Rectangle()
                                .fill(.clear)
                                .frame(maxWidth: .infinity, maxHeight: 50)
                            ZStack {
                                
                                HStack
                                {
                                    VStack(alignment: .leading)
                                    {
                                        Text("Total Qty: {0}")
                                        Text("Total Price: {0:C}")
                                    }
                                    .shadow(color: Color(colorDark()).opacity(0.3), radius: 4, x: 0, y: 0)
                                    Spacer().frame(width: 60)
                                    Button(action: {   })
                                    {
                                        Text("Checkout")
                                        
                                    }
                                    .buttonStyle(CommonButtonStyle())
                                    Spacer()
                                }
                            }
                            //                        .background(.blue)
                            .padding(16)
                            .padding([.leading, .trailing], 24)
                            .border(width: 3, edges: [.top], color: Color(colorPrimary()))
                        }
                    }
                }
                
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
                if (isShowing)
                {
                    Rectangle()
                        .fill(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .cornerRadius(isShowing ? 20 : 0)
                        .offset(x: isShowing ? 200: 0, y: isShowing ? 24 : 0)
                        .scaleEffect(isShowing ? 0.8 : 1)
                        .onTapGesture(perform: {
                            withAnimation(.spring()) {
                                isShowing = false
                            }
                        })
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
