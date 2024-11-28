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
        
        containerView.layer.masksToBounds =  true
    }
    
    
    func setup(item: Category) {
        nameLabel.text = item.name
        if let icon = item.icon {
            imgView.image = UIImage(named: icon)

        }
        
        if let url = URL(string: item.icon ?? "") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error downloading image: \(String(describing: error))")
                    return
                }
                DispatchQueue.main.async {
                    self.imgView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
        
}
