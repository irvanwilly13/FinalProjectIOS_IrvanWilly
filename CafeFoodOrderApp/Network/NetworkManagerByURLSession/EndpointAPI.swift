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
    case createOrder(param: CreateOrderParam)
    case detailFood(id: String)
    case historyDetail(orderID: String)
    case promotion
    case cancelOrder(orderID: String)
    
    
    func path() -> String {
        switch self {
        case .getAllMenu:
            return "/phincon/api/cofa/menu/items"
        case .posts:
            return "/posts"
        case .users:
            return "/users"
        case .login:
            return "/phincon/auth/login"
        case .register:
            return "/phincon/auth/register"
        case .getByCategory:
            return "/phincon/api/cofa/menu/items/category"
        case .getAllProfile:
            return "/phincon/api/cofa/profile"
        case .getAllHistory:
            return "/phincon/api/cofa/orders"
        case .createOrder:
            return "/phincon/api/cofa/order/snap"
        case .detailFood(let id):
            return "/phincon/api/cofa/menu/item/\(id)"
        case .historyDetail(let orderID):
            return "/phincon/api/cofa/order/\(orderID)"
        case .promotion:
            return "/phincon/api/cofa/promos"
        case .cancelOrder(let orderID):
            return "/phincon/api/cofa/order/cancel/\(orderID)"
        
        }
    }
    
    func method() -> HTTPMethods {
        switch self {
        case .getAllMenu, .posts, .users, .getByCategory, .getAllHistory, .getAllProfile, .detailFood, .historyDetail, .promotion:
            return .get
        case .login, .register, .createOrder, .cancelOrder:
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getAllMenu, .posts, .users, .getAllHistory, .getAllProfile, .detailFood, .historyDetail, .promotion, .cancelOrder:
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
        case .createOrder(let param):
            let itemDetails: [[String: Any]] = param.items.map { item in
                return [
                    "id": item.id,
                    "name": item.name,
                    "price": item.price ,
                    "quantity": item.quantity
                ]
            }
            
      
            var params: [String: Any] = [
                "callbacks": [
                  "error": "https://youtube.com",
                  "finish": "https://facebook.com"
                ],
                "email": param.email,
                "items": itemDetails,
                "amount": param.amount,
            ]
            
            if let promos = param.promoCode {
                params["promo_codes"] = promos
            }
            
            return params
        case .getByCategory(let param):
            let param = [
                "category": param]
            return param
        }
    }
    
    var headers: [String:String] {
        switch self {
        case .posts, .users, .login, .register:
            return [
                "Content-Type": "application/json",
                // bisa menambahkan yang lain jika diperlukan
            ]
        case .getAllMenu, .getByCategory, .createOrder, .detailFood, .getAllHistory, .historyDetail, .getAllProfile, .promotion, .cancelOrder:
            return [
                "Content-Type": "application/json",
                "x-user-id": readToken(),
                "x-secret-app": "]k!aMHCRG=2]N6WGeYNw@3#$[:V4Wr"
                // bisa  menambahkan yang lain jika diperlukan
            ]
        }
        
        
    }
    // untuk setingan api yang menggunakan query params
    var queryParams: [String: Any]? {
        switch self {
        case .getByCategory(let param):
            let param = [
                "category": param]
            return param
        default:
            return nil
        }
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
        case .login, .register, .getByCategory, .getAllProfile, .getAllMenu, .createOrder, .detailFood, .getAllHistory, .historyDetail, .promotion, .cancelOrder:
            return Constants.baseURL + self.path()
            
//        case .getAllHistory:
//            return BaseConstants.base + self.path()
        default:
            return BaseConstants.baseURL + self.path()
        }
        
    }
    func readToken() -> String {
        guard let tokenData = KeychainHelper.shared.read(forKey: KeychainHelperKey.userID)
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
