//
//  ReviewTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 13/11/24.
//

//import UIKit
//
//class ReviewTableViewCell: UITableViewCell {
//    
//    @IBOutlet weak var reviewLabel: UILabel!
//    @IBOutlet weak var containerView: UIView!
//    
//    var onSelectedLabel: (() -> Void)?
//
//        override func awakeFromNib() {
//            super.awakeFromNib()
//            setupGesture()
//        }
//
//        private func setupGesture() {
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(reviewLabelTapped))
//            reviewLabel.isUserInteractionEnabled = true
//            reviewLabel.addGestureRecognizer(tapGesture)
//        }
//        
//        @objc private func reviewLabelTapped() {
//            onSelectedLabel?()
//        }
//    }
