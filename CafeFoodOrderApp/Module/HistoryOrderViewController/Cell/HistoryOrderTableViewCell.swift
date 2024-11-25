//
//  HistoryOrderTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 25/10/24.
//

import UIKit
import SkeletonView
import RxSwift
import RxCocoa
import RxRelay

class HistoryOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var OrderAmount: UILabel!
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var totalItem: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var orderAgainButton: UIButton!
    
    var onSelectedCategory: ((_ category: HistoryData) -> Void)?
    var onSelectedOrder: (() -> Void)?
    var cancelButtonTapped: (() -> Void)?
    private var currentData: HistoryData?

    
    
    let bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.setCornerRadius(16)
        
        detailButton.rx.tap.subscribe { [weak self] _ in
             guard let self = self, let data = self.currentData else { return }
             self.onSelectedCategory?(data)
         }.disposed(by: bag)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    func configure(data: HistoryData?) {
        guard let data = data else { return }
        self.currentData = data
        
        if let firstProduct = data.details.first?.odProducts.first {
            nameLabel.text = firstProduct.name + " \(firstProduct.quantity) Item"
        } else {
            nameLabel.text = "No product"
        }
        OrderAmount.text = "\(data.details.count) Order Item"
        orderIdLabel.text = data.orPlatformID
        totalLabel.text = "Rp. \(data.orTotalPrice)"
        statusLabel.text = data.orStatus
        switch data.orStatus?.lowercased() {
        case "paid":
            statusLabel.textColor = UIColor.systemGreen
            orderAgainButton.isHidden = false
        case "cancelled":
            statusLabel.textColor = UIColor.systemRed
            orderAgainButton.isHidden = false
        case "pending":
            statusLabel.textColor = UIColor.systemYellow
            orderAgainButton.isHidden = true
        default:
            statusLabel.textColor = UIColor.gray
            orderAgainButton.isHidden = false

        }
        
        let totalItems = data.details.flatMap { $0.odProducts }.reduce(0) { $0 + $1.quantity }
        totalItem.text = "Items: \(totalItems)"
        
        orderAgainButton.rx.tap.subscribe{ [ weak self ] _ in
            guard let self = self else { return }
            self.onSelectedOrder?()
        }.disposed(by: bag)
    }
}



