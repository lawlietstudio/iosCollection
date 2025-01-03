//
//  Asset.swift
//  TotalWealthManagement
//
//  Created by mark on 2024-11-17.
//
import Foundation
import SwiftData
import SwiftUI

@Model
final class Asset {
    var id: UUID
    var name: String
    var amount: Double?
    var currency: String
    var color: String
    
    init(name: String = "", amount: Double? = nil, currency: String = "USD", color: String = "0,0,1") {
        self.id = UUID()
        self.name = name
        self.amount = amount
        self.currency = currency
        self.color = color
    }
    
    var displayColor: Color {
        return Asset.convertToColor(colorString: color)
    }
    
    static func convertToColor(colorString: String) -> Color {
        let components = colorString.split(separator: ",").compactMap { Double($0) }
        guard components.count == 3 else { return .blue }
        return Color(red: components[0], green: components[1], blue: components[2])
    }
    
    static func randomColorString() -> String {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return "\(red),\(green),\(blue)"
    }
    
    func copy() -> Asset {
        let copy = Asset()
        copy.id = self.id
        copy.name = self.name
        copy.amount = self.amount
        copy.currency = self.currency
        copy.color = self.color
        return copy
    }
}
