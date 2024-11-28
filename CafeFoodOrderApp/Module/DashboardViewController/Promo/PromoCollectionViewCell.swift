//
//  PromoCollectionViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 21/10/24.
//

import UIKit
import Kingfisher
import SkeletonView

class PromoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSkeleton()
    }
    
    func configure(with promo: PromotionFoodData) {
        hideSkeleton()
        
        if let image = UIImage(named: promo.image ?? "") {
            imgView.image = image
        } else {
            imgView.image = UIImage(named: "errorX")
        }
        nameLabel.text = promo.name
    }
    
    private func setupSkeleton() {
        nameLabel.isSkeletonable = true
        imgView.isSkeletonable = true
        isSkeletonable = true
    }
    
    func showSkeleton() {
        nameLabel.showAnimatedGradientSkeleton()
        imgView.showAnimatedGradientSkeleton()
    }
    
    func hideSkeleton() {
        nameLabel.hideSkeleton()
        imgView.hideSkeleton()
    }
}
