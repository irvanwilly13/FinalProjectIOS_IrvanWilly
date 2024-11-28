//
//  PromotionModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 17/11/24.
//

import Foundation

struct PromotionModel: Codable {
    let status: String
    let code: Int
    let message: String
    let data: [PromotionData]
}

struct PromotionData: Codable {
    
    let prmID: Int
    let prmCode, prmName: String
    let prmValue: Int
    let prmType: String
    let prmImageURL: String
    let prmURL: String
    var isSelected: Bool = false

    enum CodingKeys: String, CodingKey {
        case prmID = "prm_id"
        case prmCode = "prm_code"
        case prmName = "prm_name"
        case prmValue = "prm_value"
        case prmType = "prm_type"
        case prmImageURL = "prm_image_url"
        case prmURL = "prm_url"
    }
}
