//
//  CancelOrderModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 21/11/24.
//

import Foundation

struct CancelModel: Codable {
    let code: Int
    let message: String
    let data: CancelData
}

// MARK: - DataClass
struct CancelData: Codable {
    let orID, orTotalPrice: Int
    let orStatus, orPaymentStatus, orPlatformID: String
    let details: [HistoryDetail]
    let orUpdatedOn, orUpdatedBy: String

    enum CodingKeys: String, CodingKey {
        case orID = "or_id"
        case orTotalPrice = "or_total_price"
        case orStatus = "or_status"
        case orPaymentStatus = "or_payment_status"
        case orPlatformID = "or_platform_id"
        case details
        case orUpdatedOn = "or_updated_on"
        case orUpdatedBy = "or_updated_by"
    }
}
