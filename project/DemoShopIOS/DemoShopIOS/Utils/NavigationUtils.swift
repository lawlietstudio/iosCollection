//
//  NavigationUtils.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 4/9/2022.
//

import Foundation
import SwiftUI

struct NavigationUtil {
    static func popToRootView() {
        findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?
            .popToRootViewController(animated: false)
    }
    
    static func goToShoppingCartView() {
        findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?
            .setViewControllers([UIHostingController(rootView: ShoppingCartView())], animated: true)
    }
    
    static func goToTransactoinView() {
        findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?
            .setViewControllers([UIHostingController(rootView: TransactionView())], animated: true)
    }

    
    static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
        
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        
        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }
        
        return nil
    }
}
