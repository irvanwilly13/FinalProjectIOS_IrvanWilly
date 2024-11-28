//
//  ProfileUserModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 07/11/24.
//

import Foundation

struct DataProfileModel: Codable {
    let status: String
    let code: Int
    let message: String
    let data: DataProfileUser
}

struct DataProfileUser: Codable {
    let prID, prUsID: Int
    let prGender: String
    let prDescription: String?
    let prAddress: String?
    let prImageURL: String?
    let prBirthdayDate: String?
    let prActive: Bool
    let prCreatedOn: String?
    let prCreatedBy: String?
    let prUpdatedOn: String?
    let prUpdatedBy: String?
    let user: User

    enum CodingKeys: String, CodingKey {
        case prID = "pr_id"
        case prUsID = "pr_us_id"
        case prGender = "pr_gender"
        case prDescription = "pr_description"
        case prAddress = "pr_address"
        case prImageURL = "pr_image_url"
        case prBirthdayDate = "pr_birthday_date"
        case prActive = "pr_active"
        case prCreatedOn = "pr_created_on"
        case prCreatedBy = "pr_created_by"
        case prUpdatedOn = "pr_updated_on"
        case prUpdatedBy = "pr_updated_by"
        case user
    }
}

struct User: Codable {
    let usFullname, usEmail, usPhoneNumber: String

    enum CodingKeys: String, CodingKey {
        case usFullname = "us_fullname"
        case usEmail = "us_email"
        case usPhoneNumber = "us_phone_number"
    }
}

