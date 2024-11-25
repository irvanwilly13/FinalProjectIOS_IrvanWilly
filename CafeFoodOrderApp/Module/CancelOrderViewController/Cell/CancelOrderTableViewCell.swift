//
//  CancelOrderTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 21/11/24.
//

import UIKit

class CancelOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
            super.awakeFromNib()
            setup()
        }

        private func setup() {
            containerView.layer.cornerRadius = 8
            containerView.layer.borderColor = UIColor.lightGray.cgColor
            containerView.layer.borderWidth = 1
        }
    }
