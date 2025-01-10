//
//  Trending.swift
//  ResponsiveUIDesign
//
//  Created by mark on 2025-01-06.
//

import SwiftUI

// Mark: Trending Dished Model and Sample Data
struct Trending: Identifiable
{
    var id: String = UUID().uuidString
    var title: String
    var subTitle: String
    var count: Int
    var image: String
}

var trendingDishes: [Trending] = [
    Trending(title: "American Favourite", subTitle: "Order", count: 120, image: "Pizza1"),
    Trending(title: "Super Supreme", subTitle: "Order", count: 90, image: "Pizza2"),
    Trending(title: "Orange Juice", subTitle: "Order", count: 110, image: "OrangeJuice"),
    Trending(title: "Chicken Mushroom", subTitle: "Order", count: 70, image: "Pizza3")
]
