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
    
    var shoppingCartServiceDelegate: ShoppingCartServiceDelegate?
    
    
    public static let shared = ShoppingCartService()
    
    func addItem(cartItemToAddDto: CartItemToAddDto)
    {
        if let url = URL(string: Constants.apiDomain + "api/ShoppingCart")
        {
            let session = URLSession(configuration: .default)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            let jsonData = try? JSONSerialization.data(withJSONObject: cartItemToAddDto)
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(cartItemToAddDto)
                request.httpBody = jsonData
                let jsonString = String(data: jsonData, encoding: .utf8)
                print(jsonString as Any)
            }
            catch
            {
                print(error)
            }
            
            let task = session.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    do {
                        print("success")
                        print(response as Any)
                        if (self.shoppingCartServiceDelegate != nil)
                        {
                            self.shoppingCartServiceDelegate?.performShoppingCartServiceCallBack()
                            self.shoppingCartServiceDelegate = nil
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
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
                            var results = try decoder.decode([CartItemDto].self, from: safeDate)
                            DispatchQueue.main.async {
                                for index in results.indices {
                                    results[index].newQty = results[index].qty
                                    self.cartItemDtos.append(results[index])
                                }
                                
                                self.cartItemDtos = results

                                if (self.shoppingCartServiceDelegate != nil)
                                {
                                    self.shoppingCartServiceDelegate?.performShoppingCartServiceCallBack()
                                    self.shoppingCartServiceDelegate = nil
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
    
    func UpdateQty(cartItemQtyUpdateDto: CartItemQtyUpdateDto)
    {
        if let url = URL(string: Constants.apiDomain + "api/ShoppingCart/\(cartItemQtyUpdateDto.cartItemId)")
        {
            let session = URLSession(configuration: .default)
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            let jsonData = try? JSONSerialization.data(withJSONObject: cartItemToAddDto)
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(cartItemQtyUpdateDto)
                request.httpBody = jsonData
                let jsonString = String(data: jsonData, encoding: .utf8)
                print(jsonString as Any)
            }
            catch
            {
                print(error)
            }
            
            let task = session.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    do {
                        print("success")
                        print(response as Any)
                        for (i, cartItemDto) in self.cartItemDtos.enumerated()
                        {
                            if (cartItemDto.id == cartItemQtyUpdateDto.cartItemId)
                            {
                                DispatchQueue.main.async {
                                    self.cartItemDtos[i].qty = cartItemQtyUpdateDto.qty
                                    self.cartItemDtos[i].newQty = cartItemQtyUpdateDto.qty
                                    
                                    if (self.shoppingCartServiceDelegate != nil)
                                    {
                                        self.shoppingCartServiceDelegate?.performShoppingCartServiceCallBack()
                                        self.shoppingCartServiceDelegate = nil
                                    }
                                }
                            }
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
                    do {
                        for (i, cartItemDto) in self.cartItemDtos.enumerated()
                        {
                            if (cartItemDto.id == id)
                            {
                                DispatchQueue.main.async {
                                    self.cartItemDtos.remove(at: i)
                                    
                                    if (self.shoppingCartServiceDelegate != nil)
                                    {
                                        self.shoppingCartServiceDelegate?.performShoppingCartServiceCallBack()
                                        self.shoppingCartServiceDelegate = nil
                                    }
                                }
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }
}

protocol ShoppingCartServiceDelegate
{
    func performShoppingCartServiceCallBack()
}
