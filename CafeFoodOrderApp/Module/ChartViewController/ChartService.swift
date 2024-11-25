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
        notifyChartDidUpdate()
    }
    func removeFromCart(food: ProductFood) {
        guard let count = cartItems[food] else { return } // Jika item tidak ada, keluar
        if count <= 1 {
            cartItems.removeValue(forKey: food) // Hapus item sepenuhnya
        } else {
            cartItems[food] = count - 1 // Kurangi jumlah item
        }
        notifyChartDidUpdate()
    }
    
    //    func removeFromCart(food: ProductFood) {
    //        guard let count = cartItems[food], count > 0 else { return }
    //        if count == 1 {
    //            cartItems.removeValue(forKey: food)
    //        } else {
    //            cartItems[food] = count - 1
    //        }
    //    }
    func clearCart() {
        cartItems.removeAll()
        notifyChartDidUpdate()
    }
    
    
    func getCartItem() -> [CartTupleModel] {
        return cartItems.map { ($0.key, $0.value)}
    }
    
    func notifyChartDidUpdate() {
        NotificationCenter.default.post(name: Notification.Name("ChartUpdate"), object: nil)
    }
}
