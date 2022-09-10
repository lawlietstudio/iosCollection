//
//  TransactionView.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 9/9/2022.
//

import SwiftUI

struct TransactionView: View, TransactionServiceDelegate {
    @State private var isShowing = false;
    @State private var isLoading = false;
    @ObservedObject var transactionService = TransactionService.shared
    
    func performTransactionServiceCallBack() {
        DispatchQueue.main.async {
            isLoading = false
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
                    List($transactionService.transactionDtos) { $transactionDto in
                        ZStack {
                            Color.white.opacity(0.3)
                                .frame(maxWidth: .infinity, maxHeight:. infinity)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadow(color: Color(colorDark()).opacity(0.3), radius: 4, x: 0, y: 0)
//                            VStack(alignment: .leading) {
//                                HStack {
                                    VStack(alignment: .leading) {
        //                                Text("Date: \(transactionDto.dateTime)" )
                                        HStack {
                                            VStack(alignment:.leading) {
                                                Text("Transaction ID").foregroundColor(Color(colorPrimary())).font(.system(size:14))
                                                Text("1231-2131-1231-2133")
                                            }
                                            
                                            Spacer()
                                            VStack(alignment:.trailing) {
                                                Text("Transaction Time").foregroundColor(Color(colorPrimary())).font(.system(size:14))
                                                Text("2022-09-10 08:00")
                                            }
                                        }
                                        HStack {
                                            VStack(alignment:.leading) {
                                                Text("Total Qty").foregroundColor(Color(colorPrimary())).font(.system(size:14))
                                                Text("\(transactionDto.totalQty)")
                                            }
                                            
                                            Spacer()
                                            VStack(alignment:.trailing) {
                                                Text("Total Price").foregroundColor(Color(colorPrimary())).font(.system(size:14))
                                                Text(decimal2Currency(NSDecimalNumber(decimal: transactionDto.totalPrice)))
                                            }
                                        }
//                                        Text("")
                                        Divider()
                                        HStack {
                                            VStack(alignment:.leading) {
                                                Text("Name").foregroundColor(Color(colorPrimary())).font(.system(size:14))
                                                ForEach($transactionDto.transactionDetailDtos) { $transactionDetailDto in
                                                    Text("\(transactionDetailDto.productName)")
                                                }
//                                                Text("Total")
                                            }
                                            Spacer()
                                            VStack {
                                                Text("Qty").foregroundColor(Color(colorPrimary())).font(.system(size:14))
                                                ForEach($transactionDto.transactionDetailDtos) { $transactionDetailDto in
                                                    Text("\(transactionDetailDto.qty)")
                                                }
//                                                Text("\(transactionDto.totalQty)")
                                            }
                                            VStack(alignment:.trailing) {
                                                Text("Price").foregroundColor(Color(colorPrimary())).font(.system(size:14))
                                                ForEach($transactionDto.transactionDetailDtos) { $transactionDetailDto in
                                                    Text("\(decimal2Currency(NSDecimalNumber(decimal: transactionDetailDto.productPrice)))")
                                                }
//                                                Text(decimal2Currency(NSDecimalNumber(decimal: transactionDto.totalPrice)))
                                            }
                                        }
//                                        Text("Total Price: " + decimal2Currency(NSDecimalNumber(decimal: transactionDto.totalPrice)))
//                                        Text("Total Qty: \(transactionDto.totalQty)")
//                                        ForEach($transactionDto.transactionDetailDtos) { $transactionDetailDto in
//                                            HStack{
//                                                Text("\(transactionDetailDto.productName)")
//                                                Spacer()
//                                                Text("x \(transactionDetailDto.qty)")
//                                            }
//                                        }
//                                        List($transactionDto.transactionDetailDtos) { $transactionDetailDto in
//                                            Text("\(transactionDetailDto.productName) x \(transactionDetailDto.qty)")
//                                                .listRowSeparator(.hidden)
//                                                .listRowBackground(Color.clear)
//                                        }
//                                        .listStyle(SidebarListStyle())
                                    }
                                    .foregroundColor(Color(colorDark()))
                                    .shadow(color: Color(colorDark()).opacity(0.3), radius: 4, x: 0, y: 0)
//                                    .frame(maxWidth: .infinity, maxHeight:.infinity)

//                                }
//
//                            }
//                            .background(.red)
//                            .frame(maxWidth: .infinity, maxHeight:. infinity)
//                                    .frame(height: 200)
                            .padding(8)
                            .padding([.top, .bottom], 8)
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
                    .listStyle(SidebarListStyle())
                    if (isLoading)
                    {
                        LoadingView()
//                        ProgressView()
                    }
                    else if (transactionService.transactionDtos.count == 0)
                    {
                        VStack(alignment:.center) {
                            Text("There are currently no transactions")
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
                transactionService.transactionServiceDelegate = self
                transactionService.getItems(userId: Constants.userId)
            }
            .navigationTitle("Transaction")
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
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
