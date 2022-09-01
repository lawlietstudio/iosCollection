//
//  ShoppingCartService.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 1/9/2022.
//

import Foundation
import SwiftUI

class ShoppingCartService: ObservableObject
{
    @Published var cartItemDtos = [CartItemDto]()
    
    public static let shared = ShoppingCartService()
    
    func getItems(userId: Int)
    {
        self.cartItemDtos.removeAll()
        if let url = URL(string: Constants.apiDomain + "api/ShoppingCart/\(userId)/GetItems")
        {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeDate = data {
                        do {
                            let results = try decoder.decode([CartItemDto].self, from: safeDate)
                            DispatchQueue.main.async {
                                self.cartItemDtos = results
                            }
                        }
                        catch
                        {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func deleteItem(id: Int)
    {
        if let url = URL(string: Constants.apiDomain + "api/ShoppingCart/\(id)")
        {
            let session = URLSession(configuration: .default)
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            let task = session.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeDate = data {
                        do {
//                            let results = try decoder.decode([CartItemDto].self, from: safeDate)
//                            DispatchQueue.main.async {
//                                self.cartItemDtos = results
//                            }
                            for (i, cartItemDto) in self.cartItemDtos.enumerated()
                            {
                                if (cartItemDto.id == id)
                                {
                                    DispatchQueue.main.async {
//                                        withAnimation(.spring()) {
                                            self.cartItemDtos.remove(at: i)
//                                        }
                                    }
                                }
                            }
                        }
                        catch
                        {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
