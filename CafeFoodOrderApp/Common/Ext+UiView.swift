//
//  Ext+UiView.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 26/10/24.
//

import Foundation
import UIKit

extension UIView {
    
    func getViewController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        while nextResponder != nil {
            nextResponder = nextResponder?.next
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    
    func setFormStyle(borderWidth: CGFloat = 1.0, borderColor: UIColor = .lightGray, cornerRadius: CGFloat = 8.0, padding: CGFloat = 16.0) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
    }
    
    func addShadow(color: UIColor = .black,
                   offset: CGSize = CGSize(width: 0, height: 5),
                   opacity: Float = 0.8,
                   radius: CGFloat = 5,
                   path: UIBezierPath? = nil) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowPath = path?.cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func addBorderLine(width: CGFloat = 1,
                       color: UIColor = .gray) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func makeCornerRadius(_ radius: CGFloat, maskedCorner: CACornerMask? = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]) {
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorner ?? [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        clipsToBounds = true
    }
    
    func setFormShadow(shadowColor: UIColor = .black, shadowOffset: CGSize = CGSize(width: 0, height: 2), shadowOpacity: Float = 0.2, shadowRadius: CGFloat = 4.0) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false
    }
    
    func setFieldPadding(left: CGFloat, right: CGFloat) {
        if let textField = self as? UITextField {
            let paddingViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: left, height: textField.frame.height))
            textField.leftView = paddingViewLeft
            textField.leftViewMode = .always
            
            let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: right, height: textField.frame.height))
            textField.rightView = paddingViewRight
            textField.rightViewMode = .always
        }
    }
}
