//
//  OrderAttributes.swift
//  LiveActivityAPI
//
//  Created by mark on 2025-04-27.
//

import SwiftUI
// MARK: Available From Xcode 14 Beta 4
import ActivityKit

struct OrderAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        // MARK: Live Activities Will Update Its View Whene Content State is Updated
        var status: Status = .received
    }
    
    // MARK: Other Properties
    var orderNumber: Int
    var orderItems: String
}

// MARK: Oder Status
// For Ths Demo Project
// Change For Your Proejct Usage
enum Status: String, CaseIterable, Codable, Equatable {
    // MARK: String Values Are SFSymbol Images
    case received = "shippingbox.fill"
    case progress = "person.bust"
    case ready = "takeoutbag.and.cup.and.straw.fill"
}
