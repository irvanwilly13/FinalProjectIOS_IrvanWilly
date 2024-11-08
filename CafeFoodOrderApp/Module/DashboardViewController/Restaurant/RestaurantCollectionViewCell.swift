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
            imgView.image = UIImage(named: item.image)
            
            // Set the restaurant name
            nameLabel.text = item.name
            
            // Set the price (check if it's not nil)
            if let price = item.price {
                priceLabel.text = String(format: "$%.2f", price)
            } else {
                priceLabel.text = "N/A"
            }
            
            // Set the number of reviews
            reviewsLabel.text = "(\(item.reviews)+) "
            
            // Set the rating
            ratingLabel.text = "\(item.rating)"
            
            // Set the delivery time (if available in `deliveryInfo`)
            if let deliveryTime = item.deliveryInfo?.time {
                timeLabel.text = deliveryTime
            } else {
                timeLabel.text = "N/A"
            }
            
            // Set favorite button appearance
            let favoriteImage = item.isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            isFavoriteButton.setImage(favoriteImage, for: .normal)
            
            // Clear and update delivery info (if available)
            if let deliveryInfo = item.deliveryInfo?.info {
                for view in deliveryLabel.arrangedSubviews {
                    deliveryLabel.removeArrangedSubview(view)
                    view.removeFromSuperview()
                }
                
                let deliveryLabelText = UILabel()
                deliveryLabelText.text = deliveryInfo
                deliveryLabelText.font = UIFont.systemFont(ofSize: 12)
                deliveryLabelText.textColor = .darkGray
                deliveryLabel.addArrangedSubview(deliveryLabelText)
            }
        }
    }
