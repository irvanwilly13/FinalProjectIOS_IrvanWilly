//
//  AddressTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 12/11/24.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var changeAddressButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var onChangeAddressTapped: (() -> Void)?
    
    override func awakeFromNib() {
            super.awakeFromNib()
        changeAddressButton.addTarget(self, action: #selector(didTapChangeAddressButton), for: .touchUpInside)

        }

    func configure(with name: String, phoneNumber: String, address: String) {
        nameLabel.text = name
        phoneNumberLabel.text = phoneNumber
        addressLabel.text = address
    }
    @objc private func didTapChangeAddressButton() {
            onChangeAddressTapped?() // Panggil closure saat tombol ditekan
        }
}
