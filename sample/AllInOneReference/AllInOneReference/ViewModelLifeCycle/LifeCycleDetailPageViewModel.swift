//
//  LifeCycleDetailPageViewModel.swift
//  AllInOneReference
//
//  Created by mark on 2023-06-20.
//

import SwiftUI

class LifeCycleDetailPageViewModel: ObservableObject
{
    @Published var isShow = false
    
    var indirectShow: Bool
    {
        return isShow
    }
    
    var fixWidth: Int {
        return calFixWidth()
    }
    
    func loadedData() -> Self
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
           // Code you want to be delayed
            self.isShow.toggle()
        }
        return self
    }
    
    func calFixWidth() -> Int
    {
        return 5
    }
}
