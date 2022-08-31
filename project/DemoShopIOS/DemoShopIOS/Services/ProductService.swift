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
    var apiDomain = "https://demoshopapi.lawlietstudio.com/"
    var isGetProductCategories = false
    @Published var isGetItemsLoading = false
    
    public static let shared = ProductService()
    
    func getItems()
    {
        isGetItemsLoading = true
        if let url = URL(string: apiDomain + "api/Product")
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
        isGetItemsLoading = false
    }
    
    func getProductCategories()
    {
        if (isGetProductCategories)
        {
            return
        }
        if let url = URL(string: apiDomain + "api/Product/GetProductCategories")
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
        isGetProductCategories = true
    }
}

