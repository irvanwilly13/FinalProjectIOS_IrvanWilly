//
//  LoginModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 22/10/24.
//

import Foundation

struct LoginParam {
    let username: String
    let password: String
}

struct LoginResponse: Codable {
    let code: Int
    let message: String
    let data: LoginData
}

// MARK: - DataClass
struct LoginData: Codable {
    let usUsername: String
    let usID: Int
    let usEmail, usFullname, usPhoneNumber: String
    let usActive: Bool
    let roles: [Role]
    let token: String?

    enum CodingKeys: String, CodingKey {
        case usUsername = "us_username"
        case usID = "us_id"
        case usEmail = "us_email"
        case usFullname = "us_fullname"
        case usPhoneNumber = "us_phone_number"
        case usActive = "us_active"
        case roles, token
    }
}

// MARK: - Role
struct Role: Codable {
    let rlCode: String

    enum CodingKeys: String, CodingKey {
        case rlCode = "rl_code"
    }
}

