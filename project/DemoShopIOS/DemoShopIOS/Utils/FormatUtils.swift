//
//  FormatUtils.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 25/8/2022.
//

import Foundation

func decimal2Currency(_ myDouble:NSDecimalNumber) -> String
{
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    // localize to your grouping and decimal separator
    currencyFormatter.locale = Locale.current

    // We'll force unwrap with the !, if you've got defined data you may need more error checking

    return currencyFormatter.string(from: myDouble) ?? ""
}

func jsonDate2Date(jsonDateString:String) -> String
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    guard let jsonDate = dateFormatter.date(from: jsonDateString) else { return "" }
    let stringFormatter = DateFormatter()
    stringFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return stringFormatter.string(from: jsonDate)
}
