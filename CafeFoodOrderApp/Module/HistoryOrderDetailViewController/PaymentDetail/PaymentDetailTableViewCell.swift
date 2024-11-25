//
//  PaymentDetailTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 13/11/24.
//

import UIKit
import SkeletonView


class PaymentDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func configure(data: HistoryDetailData) {
        subTotalLabel.text = "Rp. \(data.orTotalPrice)"
        totalLabel.text = "Rp. \(data.orTotalPrice)"
    }
    
}
