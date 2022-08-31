//
//  ProductCategoryDto.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 31/8/2022.
//

import Foundation

struct ProductCategoryDto: Decodable, Identifiable
{
    var id: Int
    var name: String
    var iconCSS: String
}
