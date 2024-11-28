//
//  AdsTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 07/11/24.
//

import UIKit
import SkeletonView

class AdsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    var adsData: AdsFoodData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if let url = URL(string: adsData?.url ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    func configure(data: AdsFoodData?) {
        guard let data = data else {
            imgView.image = UIImage(named: "placeholder")
            nameLabel.text = "Unknown"
            return
        }
        imgView.image = UIImage(named: data.image) ?? UIImage(named: "placeholder")
        nameLabel.text = data.name
    }
}

