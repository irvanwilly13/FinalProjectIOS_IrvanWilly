//
//  HistoryOrderTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 25/10/24.
//

import UIKit

class HistoryOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var idOrderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.setCornerRadius(16)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configure(data: HistoryData) {
        imgView.image = UIImage(named: data.image)
        nameLabel.text = data.orderName
        dateLabel.text = data.orderDate
        totalLabel.text = String(data.totalAmount)
        idOrderLabel.text = data.orderID
        statusLabel.text = data.status
        
        if data.status == "Completed" {
            statusLabel.textColor = UIColor.systemGreen // Warna hijau
        } else if data.status == "Cancelled" {
            statusLabel.textColor = UIColor.systemRed // Warna merah
        } else {
            statusLabel.textColor = UIColor.gray // Warna default (misalnya abu-abu)
        }
    }
}


