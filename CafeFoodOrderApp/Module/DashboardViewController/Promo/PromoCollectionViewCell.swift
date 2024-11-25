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
        
        // Konfigurasi tampilan dengan data promo
        func configure(with promo: PromotionFoodData) {
            // Hide Skeleton setelah data dimuat
            hideSkeleton()
            
            // Memuat gambar dari asset lokal berdasarkan nama gambar
            if let image = UIImage(named: promo.image ?? "") {
                imgView.image = image
            } else {
                imgView.image = UIImage(named: "errorX")
            }
            nameLabel.text = promo.name
        }
        
        // Setup tampilan Skeleton
        private func setupSkeleton() {
            nameLabel.isSkeletonable = true
            imgView.isSkeletonable = true
            isSkeletonable = true
        }
        
        // Tampilkan Skeleton
        func showSkeleton() {
            nameLabel.showAnimatedGradientSkeleton()
            imgView.showAnimatedGradientSkeleton()
        }
        
        // Sembunyikan Skeleton
        func hideSkeleton() {
            nameLabel.hideSkeleton()
            imgView.hideSkeleton()
        }
    }
