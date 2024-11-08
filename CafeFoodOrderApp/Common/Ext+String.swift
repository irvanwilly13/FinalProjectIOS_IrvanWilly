//
//  Ext+String.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 05/11/24.
//

import Foundation
import UIKit

extension String {
    
    static func localized(_ string: String) -> String {
        return NSLocalizedString(string, comment: "")
    }
    
    func coloredSubstring(_ substring: String, color: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        
        // Mencari range dari substring yang ingin diwarnai
        let range = (self as NSString).range(of: substring)
        
        // Jika substring ditemukan, ubah warnanya
        if range.location != NSNotFound {
            attributedString.addAttribute(.foregroundColor, value: color, range: range)
        }
        
        return attributedString
    }
    
    /// Mengembalikan NSAttributedString dengan beberapa teks diubah warnanya dengan warna yang berbeda
    func coloredSubstrings(_ substringsWithColors: [(substring: String, color: UIColor)]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        
        // Loop untuk mencari dan mewarnai setiap substring dengan warna yang berbeda
        for (substring, color) in substringsWithColors {
            let range = (self as NSString).range(of: substring)
            
            // Jika substring ditemukan, ubah warnanya
            if range.location != NSNotFound {
                attributedString.addAttribute(.foregroundColor, value: color, range: range)
            }
        }
        
        return attributedString
    }
}

