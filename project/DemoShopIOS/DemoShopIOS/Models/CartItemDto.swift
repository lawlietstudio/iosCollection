//
//  CartItemDto.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 1/9/2022.
//

import Foundation

struct CartItemDto: Decodable, Identifiable
{
    var id: Int
    var productId: Int
    var cartId: Int
    
    var productName: String
    var productDescription: String
    var productImageURL: String
    
    var price: Decimal
    var totalPrice: Decimal
    
    var qty: Int
}
