//
//  CategoryTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 23/10/24.
//

import UIKit
import Kingfisher
import SkeletonView

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerRatingView: FormView!
    @IBOutlet weak var containerView: FormView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var isFavoriteButton: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    
    var isFavorite: Bool = false {
        didSet {
            updateFavoriteButton()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Konfigurasi awal
        configureView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Konfigurasi tampilan awal
    func configureView() {
        containerView.layer.masksToBounds = true
    }
    
    // Memperbarui tampilan tombol favorite berdasarkan status `isFavorite`
    func updateFavoriteButton() {
        let favoriteImage = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        isFavoriteButton.setImage(favoriteImage, for: .normal)
    }
    
    // Fungsi untuk mengonfigurasi cell dengan data dari model
    func configure(with food: ProductFood) {
        nameLabel.text = food.name
        descLabel.text = food.description
        if let price = food.price {
            priceLabel.text = "Rp. \(price)"
        } else {
            priceLabel.text = "Rp. -"
        }
        
        if let rating = food.rating {
            ratingLabel.text = "\(rating) "
        }
        isFavoriteButton.setImage(UIImage(systemName: food.isFavorite ? "heart.fill" : "heart" ), for: .normal)
        
        
        if let urlString = food.image, let imageUrl = URL(string: urlString) {
            imgView.kf.setImage(with: imageUrl)
        } else {
            imgView.image = UIImage(named: "errorX") // Gambar default jika urlImage tidak ada
        }
    }
    
    // Tambahkan aksi pada tombol favorite
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        isFavorite.toggle() // Mengubah status favorite
        updateFavoriteButton() // Memperbarui tampilan
        // Lakukan tindakan tambahan, seperti menyimpan perubahan status favorite
    }
    
}
