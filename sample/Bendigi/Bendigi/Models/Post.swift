//
//  Post.swift
//  Bendigi
//
//  Created by mark on 2022-11-03.
//

import Foundation

class Post : Decodable, Identifiable
{
    var postId : Int
    var id : Int
    var name : String
    var email : String
    var body : String
}
