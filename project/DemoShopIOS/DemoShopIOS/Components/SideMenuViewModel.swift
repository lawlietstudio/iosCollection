//
//  SideMenuViewModel.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 31/8/2022.
//

import Foundation
import SwiftUI

enum SideMenuViewModel: Int, CaseIterable
{
    case profile
    case lists
    case bookmarks
    case messages
    case notifications
    case logout
    
    var title: String {
        switch self {
            case .profile: return "Profile"
            case .lists: return "Lists"
            case .bookmarks: return "Bookmarks"
            case .messages: return "Messages"
            case .notifications: return "Notifications"
            case .logout: return "Logout"
        }
    }
    
    var imageName: String {
        switch self {
            case .profile: return "person"
            case .lists: return "list.bullet"
            case .bookmarks: return "bookmark"
            case .messages: return "bubble.left"
            case .notifications: return "bell"
            case .logout: return "arrow.left.square"
        }
    }
}
