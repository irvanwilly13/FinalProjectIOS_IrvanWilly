//
//  FoodCategoryTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 21/10/24.
//
import SkeletonView
import UIKit
import FirebaseAnalytics


class FoodCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var categoryItems: [Category] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var onSelectCategory: ((_ category: Category) -> Void)?
    // closure ini dipergunakan untuk mengirim data category/ jika memiliki parameter
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        FirebaseAnalytics.Analytics.logEvent("category_screen_view", parameters: [
            "screen_name": "FoodCategoryTableViewCell"
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup() {
        let nib = UINib(nibName: "FoodCategoryCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "FoodCategoryCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = layout
    }
    func configure(with categories: [Category]) {
        self.categoryItems = categories
        collectionView.reloadData()
    }
}
extension FoodCategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCategoryCollectionViewCell", for: indexPath) as?  FoodCategoryCollectionViewCell
        cell?.setup(item: categoryItems[indexPath.row])
        
        let category = categoryItems[indexPath.row]
        FirebaseAnalytics.Analytics.logEvent("category_shown", parameters: [
            "category_name": category.name,
            "category_id": category.id
        ])
        
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: (screenWidth / 3.5) - 10, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categoryItems[indexPath.row]
        FirebaseAnalytics.Analytics.logEvent("category_selected", parameters: [
            "category_name": selectedCategory.name,
            "category_id": selectedCategory.id
        ])
        onSelectCategory?(selectedCategory)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            let deselectedCategory = categoryItems[indexPath.row]
            
            FirebaseAnalytics.Analytics.logEvent("category_deselected", parameters: [
                "category_name": deselectedCategory.name,
                "category_id": deselectedCategory.id
            ]) 
        }
}

extension FoodCategoryTableViewCell: SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return "FoodCategoryCollectionViewCell"
    }
}

