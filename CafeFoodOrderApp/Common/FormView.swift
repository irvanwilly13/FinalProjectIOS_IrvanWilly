//
//  FormView.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 22/10/24.
//

import UIKit

class FormView: UIView {
    
    var cornerRadius: CGFloat = 10
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        applyShadow(on: self.frame)
    }
    
    func applyShadow(on rect: CGRect) {
        self.addShadow(color: .black,
                       offset: CGSize(width: 0, height: 3),
                       opacity: 0.5,
                       radius: 5)

        self.layer.masksToBounds = false
    }
    
    func setup() {
        self.addBorderLine(width: 0.5, color: UIColor(white: 0, alpha: 0.05))
        self.backgroundColor = .white
        self.makeCornerRadius(20, maskedCorner: [[.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]])
    }
}
