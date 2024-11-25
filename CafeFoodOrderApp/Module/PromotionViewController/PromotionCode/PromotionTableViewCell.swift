//
//  PromotionTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 17/11/24.
//

import UIKit
import Kingfisher

class PromotionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var selectImgView: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var onPromoSelected: ((String) -> Void)?
    var isSelectedPromo: Bool = false {
        didSet {
            updateButtonAppearance()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectImgView.image = UIImage(named: "circle")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func configure(data: PromotionData, isSelected: Bool) {
        nameLabel.text = data.prmName
        codeLabel.text = data.prmCode
        
        if data.prmType == "amount" {
            valueLabel.text = String(data.prmValue)
            
        } else if data.prmType == "percentage"{
            valueLabel.text = "potongan \(String(data.prmValue))%"
        }
        
        if let imageUrl = URL(string: data.prmImageURL) {
            imgView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "default_promo"))
        } else {
            imgView.image = UIImage(named: "default_promo")
        }
        self.isSelectedPromo = isSelected
        updateButtonAppearance()
        
    }
    private func updateButtonAppearance() {
        selectImgView.image = isSelectedPromo ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
        contentView.backgroundColor = isSelectedPromo ? UIColor.systemBlue.withAlphaComponent(0.1) : .white
    }
    
}

