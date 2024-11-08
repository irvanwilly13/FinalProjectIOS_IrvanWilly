//
//  EndpointAPI.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 22/10/24.
//


import Foundation
import UIKit
enum ParameterEncoding: String {
    case query
    case json
}

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

enum EndpointAPI {
    case login(param: LoginParam)
    case register(registerParam: RegistParam)
    case getAllMenu
    case posts
    case users
    case getByCategory(item: String)
    case getAllProfile
    case getAllHistory
    
    func path() -> String {
        switch self {
        case .getAllMenu:
            return "/cofa/menu/items"
        case .posts:
            return "/posts"
        case .users:
            return "/users"
        case .login:
            return "/auth/cofa/login"
        case .register:
            return "/auth/cofa/register"
        case .getByCategory(let item):
            return "/api/cofa/menu/items/category/\(item)"
        case .getAllProfile:
            return "/api/cofa/profile"
        case .getAllHistory:
            return "/getallhistory"
        }
    }
    
    func method() -> HTTPMethods {
        switch self {
        case .getAllMenu, .posts, .users, .getByCategory, .getAllHistory, .getAllProfile:
            return .get
        case .login, .register:
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getAllMenu, .posts, .users, .getAllHistory, .getAllProfile, .getByCategory:
            return nil
        case .login(let param):
            let params = [
                "username": param.username,
                "password": param.password
            ]
            return params
        case .register(let registerParam):
            let registerParams = [
                "username": registerParam.username,
                "password": registerParam.password,
                "fullname": registerParam.fullname,
                "phoneNumber": registerParam.phoneNumber,
                "email": registerParam.email
            ]
            return registerParams
        }
    }
    
    var headers: [String:String] {
        switch self {
        case .posts, .users, .login, .register, .getAllHistory, .getAllProfile:
            return [
                "Content-Type": "application/json",
                // bisa menambahkan yang lain jika diperlukan
            ]
        case .getAllMenu, .getByCategory:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(readToken())"
                // bisa  menambahkan yang lain jika diperlukan
            ]
        }
        
        
    }
    // untuk setingan api yang menggunakan query params
    var queryParams: [String: Any]? {
        return nil
//        switch self {
//        case .getByCategory(let param):
//            let param = [
//                "category": param.lowercased()]
//            return param
//        default:
//            return nil
//        }
    }
    var encoding: ParameterEncoding {
        // Mengembalikan encoding yang sesuai; misalnya untuk `getByCategory`, gunakan `.url`
        switch self {
        case .getByCategory:
            return .query
        default:
            return .json
        }
    }

    // variabel getter untuk menghasilkan full url dari api
    var urlString: String {
        
        switch self {
        case .login, .register, .getByCategory, .getAllProfile:
            return Constants.baseURL + self.path()
            
        case .getAllMenu, .getAllHistory:
            return BaseConstants.base + self.path()
        default:
            return BaseConstants.baseURL + self.path()
        }
        
    }
    func readToken() -> String {
        guard let tokenData = KeychainHelper.shared.read(forKey: KeychainHelperKey.firebaseAuthToken)
        else { return "" }
        let token = String(data: tokenData, encoding: .utf8) ?? ""
        return token
    }
    
    }

struct BaseConstants {
    static let baseURL = "https://jsonplaceholder.typicode.com"
    static let base = "http://localhost:3001/api"
    static let userDefaults = UserDefaults.standard
}
