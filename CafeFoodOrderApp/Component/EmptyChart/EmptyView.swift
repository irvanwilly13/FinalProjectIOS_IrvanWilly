//
//  EmptyView.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 21/10/24.
//

import UIKit

class EmptyView: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
        
        view.frame = self.bounds
        view.backgroundColor = .clear
        self.addSubview(view)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    func updateMessage(_ message: String) {
            nameLabel.text = message
        }
    func updateImage(_ image: UIImage?) {
            imgView.image = image
        }
    
}
