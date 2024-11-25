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

    let category: ProductCategory
    let items: [ProductFood]

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case category = "category"
    }
}

// MARK: - Category
struct ProductCategory: Codable, Hashable {
    let name: String
    let image: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case image = "image"
        case description = "description"
    }
}

// MARK: - Product
struct ProductFood: Codable, Hashable {
    let id: Int
    let name: String
    let image: String?
    let price: Int?
    let rating: String?
    let reviews: Int?
    let isFavorite: Bool
    let description: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
        case price = "price"
        case rating = "rating"
        case reviews = "reviews"
        case isFavorite = "isFavorite"
        case description = "description"
    }
}

