//
//  ChartService.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 23/10/24.
//

import Foundation
import UIKit

typealias CartTupleModel = (food: ProductFood, quantity: Int)

class CartService {
    static let shared = CartService()
    private init () {}
    
    private var cartItems: [ProductFood: Int] = [:]
    
    func addToCart(food: ProductFood) {
        cartItems[food, default: 0] += 1
    }
    
    func removeFromCart(food: ProductFood) {
        guard let count = cartItems[food], count > 0 else { return }
        if count == 1 {
            cartItems.removeValue(forKey: food)
        } else {
            cartItems[food] = count - 1
        }
    }

    
    func getCartItem() -> [CartTupleModel] {
        return cartItems.map { ($0.key, $0.value)}
    }
}
