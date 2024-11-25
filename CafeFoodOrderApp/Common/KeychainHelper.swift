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
    
    // Fungsi untuk menyimpan data ke Keychain
    func save(_ data: Data, forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key, // Nama key
            kSecValueData as String: data // Data yang disimpan
        ]
        
        // Hapus item jika sudah ada sebelumnya
        SecItemDelete(query as CFDictionary)
        
        // Tambahkan item baru ke Keychain
        let status = SecItemAdd(query as CFDictionary, nil)
        
        // Cek apakah ada kesalahan
        if status != errSecSuccess {
            print("Gagal menyimpan data ke Keychain dengan kode error: \(status)")
        }
    }
    
    // Fungsi untuk mengambil data dari Keychain
    func read(forKey key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        // Jika statusnya success, kembalikan data
        if status == errSecSuccess {
            return item as? Data
        } else {
            print("Gagal membaca data dari Keychain dengan kode error: \(status)")
            return nil
        }
    }
    
    // Fungsi untuk menghapus data dari Keychain
    func delete(forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        // Cek apakah ada kesalahan saat menghapus
        if status != errSecSuccess {
            print("Gagal menghapus data dari Keychain dengan kode error: \(status)")
        }
    }
}

class KeychainHelperKey {
    static let userID = "userID"
}


