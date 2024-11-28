//
//  Ext+UiFont.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 28/11/24.
//

import Foundation
import UIKit

extension UIFont {
    
    static func foodCrotah(_ size: CGFloat) -> UIFont {
        return UIFont(
            name: "CrotahFreeVersionItalic",
            size: size) ?? .systemFont(ofSize: size)
    }
    
    static func foodBlackNorth(_ size: CGFloat) -> UIFont {
        return UIFont(
            name: "BlackNorth",
            size: size) ?? .systemFont(ofSize: size)
    }
    
    static func foodBrownieStencil(_ size: CGFloat) -> UIFont {
        return UIFont(
            name: "BrownieStencil",
            size: size) ?? .systemFont(ofSize: size)
    }
    
    static func foodDripOctober(_ size: CGFloat) -> UIFont {
        return UIFont(
            name: "DripOctober",
            size: size) ?? .systemFont(ofSize: size)
    }
    static func foodOpenSansBold(_ size: CGFloat) -> UIFont {
        return UIFont(
            name: "OpenSansBold",
            size: size) ?? .systemFont(ofSize: size)
    }
    static func foodOpenSansBoldItalic(_ size: CGFloat) -> UIFont {
        return UIFont(
            name: "OpenSans-BoldItalic",
            size: size) ?? .systemFont(ofSize: size)
    }
    static func foodOpenSansItalic(_ size: CGFloat) -> UIFont {
        return UIFont(
            name: "OpenSans-Italic",
            size: size) ?? .systemFont(ofSize: size)
    }

}
