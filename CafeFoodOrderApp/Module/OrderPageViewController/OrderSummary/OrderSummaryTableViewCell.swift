//
//  OrderSummaryTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 12/11/24.
//

import UIKit

class OrderSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var shippingDiscountLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    
    
    override func awakeFromNib() {
            super.awakeFromNib()
        }

        func configure(total: String, discount: String, shipping: String, subTotal: String) {
            totalLabel.text = total
            shippingDiscountLabel.text = discount
            deliveryFeeLabel.text = shipping
            subTotalLabel.text = subTotal
        }
    }
