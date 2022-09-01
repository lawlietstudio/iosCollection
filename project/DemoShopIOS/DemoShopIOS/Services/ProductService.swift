//
//  ProductService.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 23/8/2022.
//

import Foundation

class ProductService: ObservableObject
{
    @Published var productDtos = [ProductDto]()
    @Published var productCategoryDtos = [ProductCategoryDto]()
    
    public static let shared = ProductService()
    
    func getItems()
    {
        self.productDtos.removeAll()
        if let url = URL(string: Constants.apiDomain + "api/Product")
        {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeDate = data {
                        do {
                            let results = try decoder.decode([ProductDto].self, from: safeDate)
                            DispatchQueue.main.async {
                                self.productDtos = results
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
    
    func getItemByCategory(categoryId: Int)
    {
        self.productDtos.removeAll()
        if let url = URL(string: Constants.apiDomain + "api/Product/\(categoryId)/GetItemsByCategory")
        {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeDate = data {
                        do {
                            let results = try decoder.decode([ProductDto].self, from: safeDate)
                            DispatchQueue.main.async {
                                self.productDtos = results
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
    
    func getProductCategories()
    {
        if (self.productCategoryDtos.count > 0)
        {
            return
        }
        if let url = URL(string: Constants.apiDomain + "api/Product/GetProductCategories")
        {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode([ProductCategoryDto].self, from: safeData)
                            DispatchQueue.main.async {
                                self.productCategoryDtos = results
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

