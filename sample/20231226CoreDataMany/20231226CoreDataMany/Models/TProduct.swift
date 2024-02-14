//
//  TProduct.swift
//  20231226CoreDataMany
//
//  Created by mark on 2023-12-26.
//

import Foundation
import CoreData

//enum ProductType {
//    case hjProduct, tProduct
//}

struct TProduct {
    var name: String
}

struct HJProduct {
    var name: String
}

struct DisplayableProduct {
    var productType: ProductType
    var tProduct: TProduct?
    var hjProduct: HJProduct?
}

extension DisplayableProduct {
    func toCDDisplayableProduct(context: NSManagedObjectContext) -> CDDisplayableProduct {
        let cdDisplayableProduct = CDDisplayableProduct(context: context)
        cdDisplayableProduct.productType = self.productType.rawValue
        switch self.productType {
        case .tProduct:
            let cdTProduct = CDTProduct(context: context)
            cdTProduct.name = self.tProduct?.name
            cdDisplayableProduct.tProduct = cdTProduct
        case .hjProduct:
            let cdHJProduct = CDHJProduct(context: context)
            cdHJProduct.name = self.hjProduct?.name
            cdDisplayableProduct.hjProduct = cdHJProduct
        }
        return cdDisplayableProduct
    }

    static func fromCDDisplayableProduct(_ cdDisplayableProduct: CDDisplayableProduct) -> DisplayableProduct {
        if let cdTProduct = cdDisplayableProduct.tProduct {
            return DisplayableProduct(productType: .tProduct, tProduct: TProduct(name: cdTProduct.name ?? ""), hjProduct: nil)
        } else if let cdHJProduct = cdDisplayableProduct.hjProduct {
            return DisplayableProduct(productType: .hjProduct, tProduct: nil, hjProduct: HJProduct(name: cdHJProduct.name ?? ""))
        } else {
            fatalError("Invalid state: CDDisplayableProduct must have either a tProduct or hjProduct")
        }
    }
}
