//
//  TransactionDto.swift
//  DemoShopIOS
//
//  Created by Mark Ho on 9/9/2022.
//

import Foundation

struct TransactionDto: Decodable, Identifiable
{
    var id: Int
    var transactionId: UUID
    var totalQty: Int
    var totalPrice: Decimal
    var dateTime: String
    var transactionDetailDtos: [TransactionDetailDto]
}
