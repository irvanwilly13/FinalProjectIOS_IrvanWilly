//
//  PickAddressTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 18/11/24.
//

import UIKit
import CoreData

class PickAddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    
    //MARK: CLOSURE, DIGUNAKAN UNTUK MEMBERIKAN NAVIGASI ATAU SELECT YANG BERADA DI DALAM TABLEVIEW
    var onDeleteTapped: (() -> Void)?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with address: AddressModel) {
        let formattedAddress = """
            \(address.alamat ?? ""),
            \(address.kabupaten ?? ""), \(address.profinsi ?? ""),
            \(address.kodePos ?? "")
            """
        addressLabel.text = formattedAddress
    }
    @objc private func didTapDeleteButton() {
            // Panggil closure saat tombol delete ditekan
            onDeleteTapped?()
        }
}
