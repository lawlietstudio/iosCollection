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
        let components = color.split(separator: ",").compactMap { Double($0) }
        guard components.count == 3 else { return .blue }
        return Color(red: components[0], green: components[1], blue: components[2])
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
