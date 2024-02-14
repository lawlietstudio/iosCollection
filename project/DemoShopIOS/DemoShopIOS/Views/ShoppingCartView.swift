//
//  ShoppingCartView.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 1/9/2022.
//
import SwiftUI
import CachedAsyncImage

struct ShoppingCartView: View, ShoppingCartServiceDelegate, TransactionServiceDelegate {
    @State private var isShowing = false;
    @State private var isLoading = false;
    @State private var isPresentSuccess = false;
    @State private var transId = ""
    @State private var totalQty = 0
    @State private var totalPrice:Decimal = 0.0
    @ObservedObject var shoppingCartService = ShoppingCartService.shared
    @ObservedObject var transactionService = TransactionService.shared
    
    
    func performShoppingCartServiceCallBack() {
        DispatchQueue.main.async {
            isLoading = false
            totalQty = 0
            totalPrice = 0
            for index in shoppingCartService.cartItemDtos.indices
            {
                totalQty += shoppingCartService.cartItemDtos[index].qty
                totalPrice += shoppingCartService.cartItemDtos[index].price * Decimal(shoppingCartService.cartItemDtos[index].qty)
            }
        }
    }
    
    func performTransactionServiceCheckoutCallBack(transactoinId: String) {
        DispatchQueue.main.async {
            isLoading = false
            isPresentSuccess = true
            transId = transactoinId
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.secondarySystemBackground).ignoresSafeArea()
                if (isShowing)
                {
                    SideMenuView(isShowing:$isShowing)
                }
                ZStack {
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
                                            Text("Qty: \(cartItemDto.newQty)")
                                                .foregroundColor((cartItemDto.newQty != cartItemDto.qty) ? Color(colorDanger()) : Color(colorDark()))
                                        }
                                        .foregroundColor(Color(colorDark()))
                                        .shadow(color: Color(colorDark()).opacity(0.3), radius: 4, x: 0, y: 0)
                                        Spacer()
                                    }
                                    HStack {
                                        Spacer().frame(width: 20)
                                        Button(action: {
                                            if (cartItemDto.newQty > 1)
                                            {
                                                cartItemDto.newQty -= 1
                                            }
                                        })
                                        {Text("- 1")}
                                            .buttonStyle(CommonButtonStyle())
                                        Spacer().frame(width: 10)
                                        Button(action: { cartItemDto.newQty += 1 })
                                        {Text("+ 1")}
                                            .buttonStyle(CommonButtonStyle())
                                        Spacer().frame(width: 10)
                                        Button(action: {
                                            isLoading = true
                                            shoppingCartService.shoppingCartServiceDelegate = self
                                            let cartItemQtyUpdateDto: CartItemQtyUpdateDto = CartItemQtyUpdateDto(cartItemId: cartItemDto.id, qty: cartItemDto.newQty)
                                            shoppingCartService.UpdateQty(cartItemQtyUpdateDto: cartItemQtyUpdateDto)
                                        })
                                        {
                                            Text("Update")
                                            
                                        }
                                            .buttonStyle(CommonButtonStyle())
                                            .opacity((cartItemDto.newQty != cartItemDto.qty) ? 1 : 0)
                                        Spacer().frame(width: 20)
                                    }
                                    HStack {
                                        Spacer().frame(width: 20)
                                        Button(action: {
                                            isLoading = true
                                            shoppingCartService.shoppingCartServiceDelegate = self
                                            shoppingCartService.deleteItem(id: cartItemDto.id )
                                        })
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
                        .padding(.horizontal, -16)
                        .disabled(isShowing)
                        .animation(Animation.spring())
                        .listStyle(SidebarListStyle())
                        if (!isShowing && shoppingCartService.cartItemDtos.count > 0)
                        {
                            ZStack {
                                Rectangle()
                                    .fill(Color(UIColor.secondarySystemBackground))
                                    .frame(maxWidth: .infinity, maxHeight: 70)
                                ZStack {
                                    
                                    HStack
                                    {
                                        VStack(alignment: .leading)
                                        {
                                            Text("Total Qty: \(totalQty)")
                                            Text("Total Price: " + decimal2Currency(NSDecimalNumber(decimal: totalPrice)))
                                        }
                                        .font(.system(size: 14))
                                        .foregroundColor(Color(colorDark()))
                                        .shadow(color: Color(colorDark()).opacity(0.3), radius: 4, x: 0, y: 0)
                                        Spacer()
                                        Button(action: {
                                            isLoading = true
                                            transactionService.transactionServiceDelegate = self
                                            transactionService.checkout(userId: Constants.userId)
                                        })
                                        {
                                            Text("Checkout")
                                        }
                                        .frame(width: 120)
                                        .buttonStyle(CommonButtonStyle())
//                                        Spacer()
                                    }
                                }
                                //                        .background(.blue)
                                .padding(16)
                                .padding([.leading, .trailing], 12)
                                .border(width: 3, edges: [.top], color: Color(colorPrimary()))
                            }
                        }
                    }
                    if (isLoading)
                    {
                        LoadingView()
//                        ProgressView()
                    }
                    else if (shoppingCartService.cartItemDtos.count == 0)
                    {
                        VStack(alignment:.center) {
                            Text("There are currently no items in your shopping cart")
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(colorDark()))
                                .shadow(color: Color(colorDark()).opacity(0.3), radius: 4, x: 0, y: 0)
                        }
                    }
                    if (isShowing)
                    {
                        Rectangle()
                            .fill(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .onTapGesture(perform: {
                                withAnimation(.spring()) {
                                    isShowing = false
                                }
                            })
                    }

                }
                .cornerRadius(isShowing ? 20 : 0)
                .offset(x: isShowing ? 200: 0, y: isShowing ? 24 : 0)
                .scaleEffect(isShowing ? 0.8 : 1)
            }
            .onAppear{
                isLoading = true
                shoppingCartService.shoppingCartServiceDelegate = self
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
                           label: {Image(systemName: "text.justify")
                            .font(.system(size: 14))
                        .foregroundColor(.white)})
                    
                }
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $isPresentSuccess) {
            Alert(
                title: Text("Success"),
                message: Text("Transaction is successfully made with Id: \(transId)"),
                dismissButton: .default(
                    Text("Confirm"),
                    action: {
                        NavigationUtil.goToTransactoinView()
                    }
                )
            )
        }
    }
}

//struct ShoppingCartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingCartView()
//    }
//}
