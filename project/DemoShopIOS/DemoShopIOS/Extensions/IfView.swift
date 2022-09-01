//
//  ifView.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 1/9/2022.
//

import SwiftUI

extension View {
  @ViewBuilder
  func `if`<Transform: View>(
    _ condition: Bool,
    transform: (Self) -> Transform
  ) -> some View {
    if condition {
      transform(self)
    } else {
      self
    }
  }
}
