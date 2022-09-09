//
//  TransactionDetailDto.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 9/9/2022.
//

import Foundation

struct TransactionDetailDto: Decodable, Identifiable
{
    var id: Int
    var qty: Int
    var productName: String
    
    var productImageURL: String
    var productPrice: Decimal
}
