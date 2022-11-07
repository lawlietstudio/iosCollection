//
//  Item.swift
//  SoloLearnToDoList
//
//  Created by mark on 2022-11-05.
//

import Foundation

class Item: NSCoder, NSSecureCoding
{
    static var supportsSecureCoding: Bool = true
    
    static let Dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    static let ArchiveURL = Dir.appendingPathComponent("items")
    
    var name: String
    
    required convenience init?(coder aDecoder: NSCoder) {
      let name = aDecoder.decodeObject(forKey: "name") as! String
      self.init(name: name)
    }
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
      aCoder.encode(name, forKey: "name")
    }
}
