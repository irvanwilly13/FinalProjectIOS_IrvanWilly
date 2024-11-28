//
//  PopularItemTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 22/10/24.
//

import UIKit
import SkeletonView

class PopularItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var popularData: [ProductFood] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        
    }
    func setup() {
        let nib = UINib(nibName: "PopularItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "PopularItemCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = layout
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func configure(with popularItems: [ProductFood]) {
        self.popularData = popularItems
    }
    
}

extension PopularItemTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularItemCollectionViewCell", for: indexPath) as?  PopularItemCollectionViewCell
        cell?.setup(item: popularData[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: (screenWidth / 2) - 10, height: 220)
    }
}

extension PopularItemTableViewCell: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> String {
        return "PopularItemCollectionViewCell"
    }
}
