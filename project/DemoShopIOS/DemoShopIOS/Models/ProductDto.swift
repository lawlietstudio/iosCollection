//
//  ProductDto.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 23/8/2022.
//

import Foundation

struct ProductDto: Decodable, Identifiable
{
    var id: Int
    var name: String
    var description: String
    var imageURL: String
    var price: Decimal
    var qty: Int
    var categoryId: Int
    var categoryName: String
}
