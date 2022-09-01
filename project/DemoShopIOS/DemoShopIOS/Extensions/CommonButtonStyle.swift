//
//  CommonButtonStyle.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 1/9/2022.
//

import SwiftUI

struct CommonButtonStyle: ButtonStyle {
    var color: Color = Color(colorPrimary())
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(color)
            .padding([.leading, .trailing], 15)
            .padding([.top, .bottom], 8)
            .font(.system(size: 16, weight: .light))
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(color, lineWidth: 2)
            )
            .buttonStyle(PlainButtonStyle()) // enable button in list
    }
}
