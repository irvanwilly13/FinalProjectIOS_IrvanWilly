//
//  KeychainHelper.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 21/10/24.
//

import UIKit
import Foundation
import Security

class KeychainHelper {
    
    static let shared = KeychainHelper()
    
    private init() {}
    
    func save(_ data: Data, forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status != errSecSuccess {
            print("Gagal menyimpan data ke Keychain dengan kode error: \(status)")
        }
    }
    
    func read(forKey key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecSuccess {
            return item as? Data
        } else {
            print("Gagal membaca data dari Keychain dengan kode error: \(status)")
            return nil
        }
    }
    
    func delete(forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status != errSecSuccess {
            print("Gagal menghapus data dari Keychain dengan kode error: \(status)")
        }
    }
}

class KeychainHelperKey {
    static let userID = "userID"
}


