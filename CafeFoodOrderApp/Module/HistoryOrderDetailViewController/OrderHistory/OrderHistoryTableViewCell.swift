//
//  OrderHistoryTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 13/11/24.
//

import UIKit
import Kingfisher
import SkeletonView


class OrderHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var containerView: FormView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(data: OdProduct?) {
        
        
        if let data = data {
            nameLabel.text = data.name
            priceLabel.text = "Rp. \(data.price)"
            descLabel.text = "\(data.quantity) item(s)"
        }
        
        
    }
}
