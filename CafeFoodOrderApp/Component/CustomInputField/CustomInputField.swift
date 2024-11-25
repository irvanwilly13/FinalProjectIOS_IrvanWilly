//
//  CustomInputField.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 20/10/24.
//

import UIKit
import Foundation

class CustomInputField: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var textFieldView: FormView!
    
    var text: String? {
            get { return textField.text }
            set { textField.text = newValue }
        }
    var textColor: UIColor? {
            get { textField.textColor }
            set { textField.textColor = newValue }
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
        
        view.frame = self.bounds
        view.backgroundColor = .clear
        self.addSubview(view)
        
        configView()
    }
    
    func configView() {
        textField.placeholder = "Masukan Username"
        titleLabel.text = "Username"
        errorLabel.isHidden = true
    }
    
    func setup(title: String, placeholder: String) {
        titleLabel.text = title
        textField.placeholder = placeholder
        
    }
}
