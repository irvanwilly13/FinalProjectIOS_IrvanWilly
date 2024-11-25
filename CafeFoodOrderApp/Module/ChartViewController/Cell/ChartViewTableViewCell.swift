//
//  ChartViewTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 21/10/24.
//

import UIKit
import Kingfisher

protocol FoodChartItemTableViewCellDelegate: AnyObject {
    func cartItemCell(didTapAddFor food: ProductFood)
    func cartItemCell(didtapRemoveFor food: ProductFood)
}

class ChartViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    weak var delegate: FoodChartItemTableViewCellDelegate?
    private var food: ProductFood?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        plusButton.addTarget(self, action: #selector(addButtonTap), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTap), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func configure(with food: ProductFood, quantity: Int) {
       
        self.food = food
       
        nameLabel.text = food.name
        
        if let price = food.price {
            priceLabel.text = "Rp. \(price)"
        } else {
            priceLabel.text = "Rp. -"
        }
        countLabel.text = "\(quantity)"
        if let urlString = food.image, let imageUrl = URL(string: urlString) {
            imgView.kf.setImage(with: imageUrl)
        } else {
            imgView.image = UIImage(named: "errorX") // Gambar default jika urlImage tidak ada
        }
        descriptionLabel.text = food.description
        
    }
    @objc private func addButtonTap() {
        guard let food = food else { return }
        delegate?.cartItemCell(didTapAddFor: food)
    }
    @objc private func minusButtonTap() {
        guard let food = food else { return }
        delegate?.cartItemCell(didtapRemoveFor: food)
    }
    
    
}
