//
//  CommonButton.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 1/9/2022.
//

import SwiftUI

struct CommonButton: View {
    var color: Color = Color(colorPrimary())
    var text: String = ""
    var body: some View {
        Button(text, action: {print("Common")})
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

//struct CommonButton_Previews: PreviewProvider {
//    static var previews: some View {
//        CommonButton()
//    }
//}
