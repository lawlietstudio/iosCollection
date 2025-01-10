//
//  CardBackgroundModifier.swift
//  ResponsiveUIDesign
//
//  Created by mark on 2025-01-10.
//

import SwiftUI

struct CardBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color.cardBackground)
                    .shadow(color: .reversedSystem.opacity(0.05), radius: 8, x: 0, y: 2)
            }
    }
}

extension View {
    func cardBackground() -> some View {
        self.modifier(CardBackgroundModifier())
    }
}
