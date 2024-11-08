//
//  HistoryOrderModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 25/10/24.
//

import Foundation

struct HistoryModel: Codable {
    let status: Int?
    let message: String?
    let data: [HistoryData]
}

// MARK: - Datum
struct HistoryData: Codable {
    let orderID, orderDate, orderName: String
    let totalAmount: Double
    let status: String
    let image: String
}
