//
//  PostData.swift
//  HackerNews
//
//  Created by Mark Ho on 23/8/2022.
//

import Foundation

struct Results: Decodable
{
    let hits: [Post]
}

struct Post: Decodable, Identifiable
{
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}
