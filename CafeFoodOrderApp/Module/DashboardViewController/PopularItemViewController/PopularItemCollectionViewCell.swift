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
    func setup(item: FeaturedRestaurant) {
        imgView.image = UIImage(named: item.image)
        nameLabel.text = item.name
        descriptionLabel.text = item.description
        ratingLabel.text = String(item.rating)
        reviewsLabel.text = String(item.reviews)
        
        if let price = item.price {
            priceLabel.text = String(format: "%.2f", price)
        } else {
            priceLabel.text = "N/A"
        }
        
        // Set the number of reviews
        reviewsLabel.text = "\(item.reviews) reviews"
        
        // Set the rating
        ratingLabel.text = "\(item.rating)"
        
        
        // Set favorite button appearance
        let favoriteImage = item.isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        isFavoriteButton.setImage(favoriteImage, for: .normal)
    }
}


