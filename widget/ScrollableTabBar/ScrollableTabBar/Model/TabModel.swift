//
//  TabModel.swift
//  ScrollableTabBar
//
//  Created by mark on 2024-04-29.
//

import Foundation

struct TabModel: Identifiable {
    // Size and the minX properties will be used for dynamic sizing and positioning the indicator in the tab bar
    private(set) var id: Tab
    var size: CGSize = .zero
    var minX: CGFloat = .zero
    
    enum Tab: String, CaseIterable {
        case research = "Research"
        case development = "Development"
        case analytics = "Analytics"
        case audience = "Audience"
        case privacy = "Privacy"
    }
}
