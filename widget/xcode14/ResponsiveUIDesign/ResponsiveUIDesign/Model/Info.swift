//
//  Info.swift
//  ResponsiveUIDesign
//
//  Created by mark on 2025-01-03.
//

import SwiftUI

// MARK: Info Cards And Sample Data
struct Info: Identifiable
{
    var id: String = UUID().uuidString
    var title: String
    var amount: String
    var percentage: Int
    var loss: Bool = false
    var icon: String
    var iconColor: Color
}

var infos: [Info] = [
    Info(title: "Revenue", amount: "$2.047", percentage: 10, loss: true, icon: "arrow.up.right", iconColor: Color("Orange")),
    Info(title: "Orders", amount: "356", percentage: 20, icon: "cart", iconColor: Color.green),
    Info(title: "Dine in", amount: "220", percentage: 10, icon: "fork.knife", iconColor: Color.red),
    Info(title: "Take Away", amount: "135", percentage: 5, loss: true, icon: "takeoutbag.and.cup.and.straw", iconColor: Color.yellow)
]
