//
//  Character.swift
//  ScrollViewWithDynamicSections
//
//  Created by mark on 2025-05-13.
//

import SwiftUI

// MARK: Character Model For Holding Data about Each Alphabet
struct Character: Identifiable {
    var id: String = UUID().uuidString
    var value: String
    var index: Int = 0
    var rect: CGRect = .zero
    var pusOffset: CGFloat = 0
    var isCurrent: Bool = false
    var color: Color = .clear
}
