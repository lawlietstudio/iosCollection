//
//  Item.swift
//  InterestCalculator
//
//  Created by mark on 2024-11-17.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
