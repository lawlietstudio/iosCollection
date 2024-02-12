//
//  Post.swift
//  20231216ComplexHeroSyncScroll
//
//  Created by mark on 2023-12-18.
//

import SwiftUI

struct Post: Identifiable {
    static let isOnlinePic = true
    
    let id: UUID = .init()
    var username: String
    var content: String
    var pics: [PicItem]
    
    /// View Base Properties
    var scrollPosition: UUID?
}

var samplePosts: [Post] = [
    .init(username: "iJustine", content: "Nature Pics", pics: Post.isOnlinePic ? onlinePics : pics),
    .init(username: "iJustine", content: "Nature Pics", pics: Post.isOnlinePic ? onlinePics.reversed() : pics.reversed()),
]

/// Constructing Pic Using Asset Images
private var onlinePics: [PicItem] = (1...5).compactMap { index -> PicItem? in
    return .init(image: "http://192.168.2.54:5500/images/pic\(index).jpg")
}

private var pics: [PicItem] = (1...5).compactMap { index -> PicItem? in
    return .init(image: "Pic \(index)")
}
