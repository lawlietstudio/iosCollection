//
//  SideMenuOptionView.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 31/8/2022.
//

import SwiftUI

struct SideMenuOptionView: View {
//    let viewModel: SideMenuViewModel
    let productCategoryDto : ProductCategoryDto?
    var imageName : String = ""
    var title : String = ""
    var body: some View {
        HStack(spacing:16) {
            Image(systemName: ((productCategoryDto != nil) ? "car" : imageName) )
                .frame(width: 24, height: 8)
            Text((productCategoryDto?.name ?? title) ).font(.system(size: 15, weight: .semibold))
            Spacer()
        }
        .padding().foregroundColor(.white)
    }
}

//struct SideMenuOptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        SideMenuOptionView(viewModel: nil)
//    }
//}
