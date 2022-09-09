//
//  TransactionService.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 9/9/2022.
//

import Foundation
import SwiftUI

class TransactionService: ObservableObject
{
    @Published var transactionDtos = [TransactionDto]()
    
    var transactionServiceDelegate: TransactionServiceDelegate?
    
    public static let shared = TransactionService()
    
    func getItems(userId: Int)
    {
        self.transactionDtos.removeAll()
        if let url = URL(string: Constants.apiDomain + "api/Transaction/\(userId)/GetItems")
        {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeDate = data {
                        do {
                            var results = try decoder.decode([TransactionDto].self, from: safeDate)
                            DispatchQueue.main.async {
                                self.transactionDtos = results

                                if (self.transactionServiceDelegate != nil)
                                {
                                    self.transactionServiceDelegate?.performTransactionServiceCallBack()
                                    self.transactionServiceDelegate = nil
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
    
    func checkout(userId: Int)
    {
//        self.transactionDtos.removeAll()
        if let url = URL(string: Constants.apiDomain + "api/Transaction/\(userId)/Checkout")
        {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    do {
                        print("success")
                        print(response as Any)
                        if (self.transactionServiceDelegate != nil)
                        {
                            self.transactionServiceDelegate?.performTransactionServiceCallBack()
                            self.transactionServiceDelegate = nil
                        }
                    }
                }
            }
            task.resume()
        }
    }
}

protocol TransactionServiceDelegate
{
    func performTransactionServiceCallBack()
}
