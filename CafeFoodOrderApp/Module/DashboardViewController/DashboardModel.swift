//
//  DashboardModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 22/10/24.
//

import Foundation
import UIKit

enum FoodCategory: String, CaseIterable, Codable {
    case burger
    case donut
    case pizza
    case mexican
    case asian
    
    func setImage() -> String {
        switch self {
        case .burger:
            return "kopi1"
        case .donut:
            return "lasagna1"
        case .pizza:
            return "pizza1"
        case .mexican:
            return "drink1"
        case .asian:
            return "drink1"
        }
    }
}


// MARK: - Welcome
struct AllMenuModel: Codable {
    let status: String
    let message: String
    let data: FoodModel
    let code: Int
}


// MARK: - Welcome
struct FoodModel: Codable {
    let categories: [Category]
    let featuredRestaurants: [FeaturedRestaurant]
    let popularItems: [ProductFood]
    let promoData: [PromotionFoodData]
    let adsData: [AdsFoodData]
}

struct PromotionFoodData: Codable {
    let name: String
    let image: String?
}

struct AdsFoodData: Codable {
    let name: String
    let image: String
    let url: String
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String
    let icon: String?
}

// MARK: - FeaturedRestaurant
struct FeaturedRestaurant: Hashable, Codable {
    let id: Int
    let name: String
    let image: String?
    let rating: Double
    let reviews: Int
    let isFavorite: Bool
    let deliveryInfo: DeliveryInfo
    let tags: [String]
}


// MARK: - DeliveryInfo
struct DeliveryInfo: Codable, Equatable, Hashable {
    let type, time: String
}


