//
//  TripCard.swift
//  ParallaxCarouselScroll
//
//  Created by mark on 2023-09-27.
//

import Foundation

/// Trip Card Model
struct TripCard: Identifiable, Hashable
{
    var id: UUID = .init()
    var title: String
    var subTitle: String
    var image: String
}

/// Sample Cards
var tripCards: [TripCard] = [
    .init(title: "London", subTitle: "England", image: "Pic 1"),
    .init(title: "New York", subTitle: "USA", image: "Pic 2"),
    .init(title: "Singapore", subTitle: "Singapore", image: "Pic 3")
]
