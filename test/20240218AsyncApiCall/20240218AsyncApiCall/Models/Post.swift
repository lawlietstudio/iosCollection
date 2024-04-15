//
//  Post.swift
//  20240218AsyncApiCall
//
//  Created by Mark Ho on 18/2/2024.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
