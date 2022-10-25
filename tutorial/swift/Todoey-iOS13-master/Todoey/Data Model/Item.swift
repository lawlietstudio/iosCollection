//
//  item.swift
//  Todoey
//
//  Created by mark on 21/10/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

//Encodable, Decodable
class Item : Codable {
    var title : String = ""
    var done : Bool = false
}
