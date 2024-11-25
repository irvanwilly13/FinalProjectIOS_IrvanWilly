//
//  DetailOrderTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 12/11/24.
//

import UIKit
import Kingfisher

class DetailOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var priceItemLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    

    
    override func awakeFromNib() {
            super.awakeFromNib()
        }

    func configure(with name: String, price: String, amount: String, totalPrice: String, imageName: String) {
            nameLabel.text = name
            priceItemLabel.text = price
            amountLabel.text = amount
            totalPriceLabel.text = totalPrice
            if let imageUrl = URL(string: imageName) {
                imgView.kf.setImage(with: imageUrl)
            } else {
                imgView.image = UIImage(named: "errorX")
            }
        }
    }
