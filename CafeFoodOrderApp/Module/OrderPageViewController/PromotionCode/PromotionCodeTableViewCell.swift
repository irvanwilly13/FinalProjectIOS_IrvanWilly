//
//  PromotionCodeTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 16/11/24.
//

import UIKit

class PromotionCodeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var getVoucherButton: UIButton!
    @IBOutlet weak var voucherField: UITextField!
    @IBOutlet weak var containerView: UIView!
    
    var onVoucherCodeEntered: ((String) -> Void)?
    var onNavigateToPromotions: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configure(with placeholder: String, selectedPromoCode: String?) {
        voucherField.placeholder = placeholder

        if let promoCode = selectedPromoCode {
            voucherField.text = promoCode
        }
        
        getVoucherButton.addTarget(self, action: #selector(getVoucherButtonTapped), for: .touchUpInside)
    }
    
    @objc private func getVoucherButtonTapped() {
        onNavigateToPromotions?()
    }
    @objc private func updateVoucherField(notification: Notification) {
        if let promoCode = notification.object as? String {
            voucherField.text = promoCode
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: .promoSelected, object: nil)
    }
}
extension Notification.Name {
    static let promoSelected = Notification.Name("promoSelected")
}
