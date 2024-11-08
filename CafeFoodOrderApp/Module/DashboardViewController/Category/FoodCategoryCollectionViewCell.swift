//
//  FoodCategoryCollectionViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 21/10/24.
//

import UIKit

class FoodCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: FormView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContainerViewAppearance()
        
        
        
    }
    func setup(item: Category) {
        nameLabel.text = item.name
        imgView.image = UIImage(named: item.icon)
        
        // Download the image from the URL (if it exists) and set it to imgView
        if let url = URL(string: item.icon) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error downloading image: \(String(describing: error))")
                    return
                }
                // Set the downloaded image to imgView on the main thread
                DispatchQueue.main.async {
                    self.imgView.image = UIImage(data: data)
                }
            }.resume() // Start the download task
        }
    }
    private func setupContainerViewAppearance() {
            // Border
            containerView.layer.borderColor = UIColor.black.cgColor
            containerView.layer.borderWidth = 0.5
            
            // Shadow
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.shadowOpacity = 0.4 // Lebih tebal, lebih terlihat
            containerView.layer.shadowOffset = CGSize(width: 0, height: 4) // Bayangan lebih dalam
            containerView.layer.shadowRadius = 8 // Lebih besar untuk kesan tebal
            
            // Rounded corners
            containerView.layer.cornerRadius = 8
            containerView.layer.masksToBounds = false
        }
    }
