//
//  CartItemQtyUpdateDto.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 4/9/2022.
//

import Foundation

struct CartItemQtyUpdateDto: Encodable
//, Identifiable
{
//    var id: Int {
//        return cartId
//    }
    var cartItemId: Int
    
    var qty: Int
}
