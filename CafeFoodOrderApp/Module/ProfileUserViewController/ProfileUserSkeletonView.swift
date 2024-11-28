//
//  ProfileUserSkeletonView.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 08/11/24.
//

import UIKit
import SkeletonView

class ProfileUserSkeletonView: UIView {
    
    
    @IBOutlet private var views: [UIView]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
        
        view.frame = self.bounds
        view.backgroundColor = .clear
        self.addSubview(view)
        
        self.isSkeletonable = true
        setup()
    }
    
    func setup() {
        views?.forEach { item in
            item.isSkeletonable = true
            item.layer.cornerRadius = 6
            item.showAnimatedGradientSkeleton()
        }
    }
}



