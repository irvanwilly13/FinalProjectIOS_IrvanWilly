//
//  HistoryOrderModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 25/10/24.
//

import Foundation

struct HistoryModell: Codable {
    let status: Int?
    let message: String?
    let data: [HistoryData]
}

struct HistoryDataa: Codable {
    let orderID, orderDate, orderName: String
    let totalAmount: Double
    let status: String
    let image: String
}

struct HistoryModel: Codable, Hashable {
    let code: Int
    let message: String
    let data: [HistoryData]
    let totalOrders, totalPages: Int
}

struct HistoryData: Codable, Hashable {
    
    let orID, orTotalPrice: Int
    var orStatus: String?
    let orPaymentStatus, orTokenID, orPlatformID: String
    let details: [HistoryDetail]
    let promos: [String]
    let createdOn: String

    enum CodingKeys: String, CodingKey {
        case orID = "or_id"
        case orTotalPrice = "or_total_price"
        case orStatus = "or_status"
        case orPaymentStatus = "or_payment_status"
        case orTokenID = "or_token_id"
        case orPlatformID = "or_platform_id"
        case details, promos
        case createdOn = "or_created_on"
    }
}

struct HistoryDetail: Codable, Hashable {
    let odProducts: [OdProduct]

    enum CodingKeys: String, CodingKey {
        case odProducts = "od_products"
    }
}

struct OdProduct: Codable, Hashable {
    let id: ProductID
    let price, quantity: Int
    let name: String
}


enum ProductID: Codable, Hashable {
    case intID(Int)
    case stringID(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self = .intID(intValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .stringID(stringValue)
        } else {
            throw DecodingError.typeMismatch(
                ProductID.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "ProductID must be Int or String")
            )
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .intID(let intValue):
            try container.encode(intValue)
        case .stringID(let stringValue):
            try container.encode(stringValue)
        }
    }
}
