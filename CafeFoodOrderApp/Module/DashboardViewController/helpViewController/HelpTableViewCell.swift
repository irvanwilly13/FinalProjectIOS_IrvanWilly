//
//  HelpTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 20/11/24.
//

import UIKit
import SkeletonView

class HelpTableViewCell: UITableViewCell {

    
    @IBOutlet weak var containerView: FormView!
    override func awakeFromNib() {
            super.awakeFromNib()
            setupGestureRecognizer()
        }

        private func setupGestureRecognizer() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(containerViewTapped))
            containerView.addGestureRecognizer(tapGesture)
            containerView.isUserInteractionEnabled = true
        }

        @objc private func containerViewTapped() {
            // Kirim notifikasi ke view controller atau lakukan navigasi di sini
            print("Container View Tapped!")
        }
    }
