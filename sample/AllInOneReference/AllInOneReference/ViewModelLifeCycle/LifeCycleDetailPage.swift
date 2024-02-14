//
//  LifeCycleDetailPage.swift
//  AllInOneReference
//
//  Created by mark on 2023-06-20.
//

import SwiftUI

struct LifeCycleDetailPage: View {
    @ObservedObject var viewModel: LifeCycleDetailPageViewModel
    
    var body: some View {
        Text("\(viewModel.indirectShow.description)")
        Text("\(viewModel.calFixWidth())")
    }
}

