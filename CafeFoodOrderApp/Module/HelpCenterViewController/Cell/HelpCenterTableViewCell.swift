//
//  HelpCenterTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 10/11/24.
//

import UIKit

class HelpCenterTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var showHideButton: UIButton!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            
            // Pengaturan tambahan jika diperlukan, seperti shadow atau corner radius pada containerView
            containerView.layer.cornerRadius = 8
            containerView.layer.masksToBounds = true
            answerLabel.isHidden = true // Awalnya tersembunyi
        }
        
        func configureCell(isExpanded: Bool) {
            answerLabel.isHidden = !isExpanded
            
            // Animasi rotasi ikon show/hide button
            UIView.animate(withDuration: 0.3) {
                self.showHideButton.transform = isExpanded ? CGAffineTransform(rotationAngle: .pi) : CGAffineTransform.identity
            }
            
            // Animasi perubahan visibilitas jawaban
            UIView.transition(with: answerLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.answerLabel.isHidden = !isExpanded
            })
        }
    }
