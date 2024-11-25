//
//  RestaurantCollectionViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 22/10/24.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var isFavoriteButton: UIButton!
    @IBOutlet weak var deliveryInfo: UIStackView!
    @IBOutlet weak var deliveryLabel: UIStackView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var containerView: FormView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.masksToBounds = true
    }
    
    func setup(item: FeaturedRestaurant) {
            // Set the restaurant image
        if let img = item.image {
            imgView.image = UIImage(named: img)
        }
            
            
            // Set the restaurant name
            nameLabel.text = item.name
            
       
            
            // Set the number of reviews
            reviewsLabel.text = "(\(item.reviews)+) "
            
            // Set the rating
            ratingLabel.text = "\(item.rating)"
            
         
            
            // Set favorite button appearance
            let favoriteImage = item.isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            isFavoriteButton.setImage(favoriteImage, for: .normal)
            
   
        }
    }
