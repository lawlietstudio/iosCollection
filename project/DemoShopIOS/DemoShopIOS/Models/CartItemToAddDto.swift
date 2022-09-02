//
//  CartItemToAddDto.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 2/9/2022.
//

import Foundation

struct CartItemToAddDto: Decodable, Identifiable
{
    var id: Int
    var productId: Int    
    var qty: Int
}
