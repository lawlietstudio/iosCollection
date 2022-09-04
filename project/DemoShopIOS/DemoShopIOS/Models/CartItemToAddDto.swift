//
//  CartItemToAddDto.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 4/9/2022.
//

import Foundation

struct CartItemToAddDto: Encodable
//, Identifiable
{
//    var id: Int {
//        return cartId
//    }
    var cartId: Int
    var productId: Int
    
    var qty: Int
}
