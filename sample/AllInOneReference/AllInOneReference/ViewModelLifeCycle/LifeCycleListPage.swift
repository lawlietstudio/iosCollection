//
//  LifeCycleListPage.swift
//  AllInOneReference
//
//  Created by mark on 2023-06-20.
//

import SwiftUI

struct LifeCycleListPage: View {
    var body: some View {
        NavigationView {
            NavigationLink {
                LifeCycleDetailPage(viewModel: LifeCycleDetailPageViewModel().loadedData())
            } label: {
                Text("go to detail")
            }
        }
    }
}

struct LifeCycleListPage_Previews: PreviewProvider {
    static var previews: some View {
        LifeCycleListPage()
    }
}
