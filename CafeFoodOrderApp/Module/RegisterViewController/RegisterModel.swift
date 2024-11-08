//
//  RegisterModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 22/10/24.
//

import Foundation


struct RegistParam: Codable {
    let username: String
    let password: String
    let email: String
    let fullname: String
    let phoneNumber: String
}

struct RegisterResponse: Codable {
    let code: Int
    let message: String
    let data: RegisterData
}

// MARK: - DataClass
struct RegisterData: Codable {
    let usCreatedOn, usUpdatedOn: String
    let usID: Int
    let usFullname, usUsername, usEmail, usPhoneNumber: String
    let usActive: Bool
    let usCreatedBy, usUpdatedBy: String?

    enum CodingKeys: String, CodingKey {
        case usCreatedOn = "us_created_on"
        case usUpdatedOn = "us_updated_on"
        case usID = "us_id"
        case usFullname = "us_fullname"
        case usUsername = "us_username"
        case usEmail = "us_email"
        case usPhoneNumber = "us_phone_number"
        case usActive = "us_active"
        case usCreatedBy = "us_created_by"
        case usUpdatedBy = "us_updated_by"
    }
}
