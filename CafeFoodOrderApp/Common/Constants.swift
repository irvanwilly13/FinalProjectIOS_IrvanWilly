//
//  Constants.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 28/10/24.
//

import Foundation

struct Constants {
    public static var baseURL: String {
        return Bundle.main.infoDictionary?["BASE_URL"] as? String ?? ""
    }
    
    public static var midtransKey: String {
        return Bundle.main.infoDictionary?["MIDTRANS_KEY"] as? String ?? ""
    }
}
