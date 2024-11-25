//
//  OrderAgainTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 14/11/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import SkeletonView

class OrderAgainTableViewCell: UITableViewCell {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var orderAgainButton: UIButton!
    @IBOutlet weak var containerView: FormView!
    
    var orderAgainButtonTapped: (() -> Void)?
    var cancelButtonTapped: (() -> Void)?

    let bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        orderAgainButton.addTarget(self, action: #selector(orderAgainButtonClicked), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @objc private func orderAgainButtonClicked() {
            orderAgainButtonTapped?()
        }
    @objc private func cancelButtonClicked() {
            cancelButtonTapped?() 
        }
    func configure(status: String?) {
            guard let status = status else { return }
            
            switch status.lowercased() {
            case "paid":
                cancelButton.isHidden = true
                orderAgainButton.setTitle("Order Again", for: .normal)
            case "pending":
                cancelButton.isHidden = false
                orderAgainButton.setTitle("Payment", for: .normal)
            default:
                cancelButton.isHidden = false
                orderAgainButton.setTitle("Order Again", for: .normal)
            }
        }
}
