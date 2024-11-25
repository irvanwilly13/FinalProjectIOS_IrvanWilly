//
//  ParameterEndpoint.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 11/11/24.
//

import Foundation

struct CreateOrderParam {
    let email: String
    let items: [OrderItem]
    let amount: Int
    let promoCode: [String]? 
}
struct OrderItem {
    let id: Int
    let name: String
    let price: Int
    let quantity: Int
    let image: String
}
