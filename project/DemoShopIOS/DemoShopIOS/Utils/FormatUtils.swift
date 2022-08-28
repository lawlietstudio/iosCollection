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
