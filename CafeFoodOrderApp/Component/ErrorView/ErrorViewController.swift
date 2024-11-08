//
//  ErrorViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 06/11/24.
//

import UIKit

protocol ErrorViewControllerDelegate {
    func buttonTap()
}

class ErrorViewController: UIView {

    @IBOutlet weak var refreshButton: UIButton!
    
    var delegate: ErrorViewControllerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
        
        view.frame = self.bounds
        view.backgroundColor = .clear
        self.addSubview(view)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    func setup() {
//        refreshButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
//    }
//    
//   @objc func tapButton() {
//        delegate?.buttonTap()
//    }
    func setup() {
            refreshButton.addTarget(self, action: #selector(refreshData), for: .touchUpInside)
        }
        
        @objc func refreshData() {
            delegate?.buttonTap()
            // Tambahkan kode di sini untuk memuat ulang data atau melakukan tindakan lain yang diperlukan
            print("Refreshing data...")
        }
    
    
}
