//
//  DetailFoodModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 11/11/24.
//

import Foundation

// MARK: - Welcome
struct DetailFoodModel: Codable, Hashable {
    let code: Int
    let message: String
    let data: DetailFoodData
}

struct DetailFoodData: Codable, Hashable {
    let id: Int
    let name: String
    let image: String?
    let totalAverageRating: Double
    let totalReviews: Int
    let isFavorite: Bool
    let description: String
    let price: Int
    let categories: [String]
    let reviews: [Review]
}

// MARK: - Review
struct Review: Codable, Hashable {
    let id: Int
    let rating: Double?
    let comment, username: String
}
