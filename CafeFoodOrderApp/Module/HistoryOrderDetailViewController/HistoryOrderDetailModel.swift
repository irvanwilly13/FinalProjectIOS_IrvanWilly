//
//  HistoryOrderDetailModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 13/11/24.
//

import Foundation

struct HistoryDetailModel: Codable, Hashable {
    let code: Int
    let message: String
    let data: HistoryDetailData
}

struct HistoryDetailData: Codable,Hashable {
    let orID, orTotalPrice: Int
    var orStatus: String?
    let orPaymentStatus, orTokenID, orPlatformID: String
    let orCreatedOn: String
    let details: [HistoryDetail]
    let promos: [String]

    enum CodingKeys: String, CodingKey {
        case orID = "or_id"
        case orTotalPrice = "or_total_price"
        case orStatus = "or_status"
        case orPaymentStatus = "or_payment_status"
        case orTokenID = "or_token_id"
        case orPlatformID = "or_platform_id"
        case orCreatedOn = "or_created_on"
        case details, promos
    }
}
