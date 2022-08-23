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
    
    func getItems()
    {
        if let url = URL(string: "https://demoshopapi.lawlietstudio.com/api/Product")
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
}

