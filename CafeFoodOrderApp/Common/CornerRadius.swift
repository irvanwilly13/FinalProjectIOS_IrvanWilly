//
//  CornerRadius.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 22/10/24.
//

import Foundation
import UIKit


extension UIView {
    
    // Function to set corner radius for any UIView
    func setCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true // Ensures subviews are clipped to the rounded corners
    }
    
}

extension UIButton {
    
    func apply3DEffect() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
        
        self.layer.cornerRadius = 16
        
        self.addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        self.addTarget(self, action: #selector(animateUp), for: [.touchUpInside, .touchCancel, .touchDragExit])
    }
    
    @objc private func animateDown() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.layer.shadowOffset = CGSize(width: 2, height: 2)
        })
    }
    
    @objc private func animateUp() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform.identity
            self.layer.shadowOffset = CGSize(width: 4, height: 4) 
        })
    }
}
