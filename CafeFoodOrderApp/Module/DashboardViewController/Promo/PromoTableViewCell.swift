//
//  PromoTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 21/10/24.
//

import UIKit
import SkeletonView

class PromoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    
    var promoFoodData: [PromotionFoodData] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup() {
        let nib = UINib(nibName: "PromoCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "PromoCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func configure(with data: [PromotionFoodData]) {
        self.promoFoodData = data
    }
}

extension PromoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return promoFoodData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromoCollectionViewCell", for: indexPath) as! PromoCollectionViewCell
        let promo = promoFoodData[indexPath.item]
        cell.configure(with: promo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.bounds.width
        return CGSize(width: (screenWidth) - 20, height: 150)
    }
}

extension PromoTableViewCell: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "PromoCollectionViewCell"
    }
}
