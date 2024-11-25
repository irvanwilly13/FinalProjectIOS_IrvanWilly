//
//  CafeFoodOrderAppTests.swift
//  CafeFoodOrderAppTests
//
//  Created by Muhammad Farrel Al Fathir on 19/11/24.
//

import XCTest
@testable import CafeFoodOrderApp

final class CafeFoodOrderAppTests: XCTestCase {
    var cartService: CartService!
        var food1: ProductFood!
        var food2: ProductFood!

    override func setUpWithError() throws {
        cartService = CartService.shared
        food1 = ProductFood(id: 103, name: "Strawberry Cream Donut", image:"https://i0.wp.com/youthsweets.com/wp-content/uploads/2023/05/StrawberryCreamDonuts_Feature.jpg?fit=1200%2C1200&ssl=1", price: 25000, rating: "", reviews: 0, isFavorite: false, description: "Donut with strawberry cream filling")
                food2 = ProductFood(id: 104, name: "Strawberry Coconut Donut", image:"https://img.freepik.com/premium-photo/pink-donuts-with-strawberry-coconut-ganache_974629-430881.jpg", price: 26000, rating: "", reviews: 0, isFavorite: false, description: "Donut topped with strawberry and coconut")
                
                // Pastikan cart kosong sebelum setiap pengujian
                cartService.getCartItem().forEach { cartService.removeFromCart(food: $0.food) }    }

    override func tearDownWithError() throws {
        cartService = nil
                food1 = nil
                food2 = nil
    }
    func testAddToCart() {
            // Tambahkan item ke cart
            cartService.addToCart(food: food1)
            cartService.addToCart(food: food1)
            cartService.addToCart(food: food2)
            
            // Ambil item di cart
            let cartItems = cartService.getCartItem()
            
            // Verifikasi jumlah item
            XCTAssertEqual(cartItems.count, 2, "Cart should have 2 distinct items.")
            
            // Verifikasi jumlah masing-masing item
            XCTAssertEqual(cartItems.first(where: { $0.food == food1 })?.quantity, 2, "Food1 should have a quantity of 2.")
            XCTAssertEqual(cartItems.first(where: { $0.food == food2 })?.quantity, 1, "Food2 should have a quantity of 1.")
        }
    func testRemoveFromCart() {
        // Tambahkan item ke cart
        cartService.addToCart(food: food1)
        cartService.addToCart(food: food1)
        cartService.addToCart(food: food2)

        // Hapus satu instance food1
        cartService.removeFromCart(food: food1)

        // Ambil item di cart
        var cartItems = cartService.getCartItem()

        // Verifikasi jumlah item
        XCTAssertEqual(cartItems.count, 2, "Cart should still have 2 distinct items.")

        // Verifikasi jumlah masing-masing item
        XCTAssertEqual(cartItems.first(where: { $0.food == food1 })?.quantity, 1, "Food1 should have a quantity of 1.")
        XCTAssertEqual(cartItems.first(where: { $0.food == food2 })?.quantity, 1, "Food2 should have a quantity of 1.")

        // Hapus food1 terakhir
        cartService.removeFromCart(food: food1)
        cartItems = cartService.getCartItem()
        
        // Pastikan food1 benar-benar dihapus
        XCTAssertNil(cartItems.first(where: { $0.food == food1 }), "Food1 should be removed from the cart.")
    }

    func testRemoveNonExistingItem() {
            // Hapus item yang tidak ada
            cartService.removeFromCart(food: food1)
            
            // Ambil item di cart
            let cartItems = cartService.getCartItem()
            
            // Verifikasi cart kosong
            XCTAssertTrue(cartItems.isEmpty, "Cart should still be empty.")
        }
    func testGetCartItem() {
            // Tambahkan beberapa item
            cartService.addToCart(food: food1)
            cartService.addToCart(food: food2)
            
            // Ambil item di cart
            let cartItems = cartService.getCartItem()
            
            // Verifikasi jumlah item
            XCTAssertEqual(cartItems.count, 2, "Cart should have 2 distinct items.")
        }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
