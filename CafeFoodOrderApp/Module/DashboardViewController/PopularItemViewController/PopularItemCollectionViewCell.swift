//
//  PopularItemCollectionViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 23/10/24.
//

import UIKit

class PopularItemCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var isFavoriteButton: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var containerView: FormView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.masksToBounds = true
    }
    func setup(item: ProductFood) {
        if let img = item.image {
            imgView.image = UIImage(named: img)

        }
        nameLabel.text = item.name
        ratingLabel.text = item.rating ?? ""
        reviewsLabel.text = "\(item.reviews) reviews"
        let favoriteImage = item.isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        isFavoriteButton.setImage(favoriteImage, for: .normal)
    }
}


