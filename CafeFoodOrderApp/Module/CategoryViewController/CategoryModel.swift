//
//  CategoryModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 23/10/24.
//

import Foundation



// MARK: - Welcome
struct FoodCategoryModel: Codable, Hashable {
    let code: Int
    let message: String
    let data: FoodCategoryData
}

// MARK: - DataClass
struct FoodCategoryData: Codable, Hashable {
    let ctID: Int
    let ctName, ctDescription: String
    let products: [ProductFood]

    enum CodingKeys: String, CodingKey {
        case ctID = "ct_id"
        case ctName = "ct_name"
        case ctDescription = "ct_description"
        case products
    }
}

// MARK: - Product
struct ProductFood: Codable, Hashable {
    let pdID: Int
    let pdName: String
    let pdImageURL: String?
    
    let pdPrice: Double?
    let pdQuantity: Int

    enum CodingKeys: String, CodingKey {
        case pdID = "pd_id"
        case pdName = "pd_name"
        case pdImageURL = "pd_image_url"
        case pdPrice = "pd_price"
        case pdQuantity = "pd_quantity"
    }
}

