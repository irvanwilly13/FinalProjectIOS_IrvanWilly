//
//  PickAddressViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 18/11/24.
//

import UIKit
import CoreData

protocol PickAddressViewControllerDelegate: AnyObject {
    func didSelectAddress(_ address: AddressModel)
}

class PickAddressViewController: UIViewController {
    
    @IBOutlet weak var addAddressButton: UIButton!
    @IBOutlet weak var toolBarView: ToolBarView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var addresses: [AddressModel] = []
    weak var delegate: PickAddressViewControllerDelegate?
    var selectedAddress: AddressModel?
    
    var isFromProfile: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchAddresses()
        
        if isFromProfile {
                    applyButton.isHidden = true
                }

    }
    
    func setup() {
        toolBarView.setup(title: "Select Address")
        tableView.register(UINib(nibName: "PickAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "PickAddressTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        addAddressButton.addTarget(self, action: #selector(acntionToAdd), for: .touchUpInside)
    }
    @objc func acntionToAdd() {
        let vc = BottomSheetAddAddressViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    @objc func fetchAddresses() {
        addresses = CoreDataManager.shared.fetchAddresses()
        tableView.reloadData()
    }
    
    @objc func applyButtonTapped() {
        guard let selectedAddress = selectedAddress else {
            print("No address selected.")
            return
        }
        delegate?.didSelectAddress(selectedAddress)
        navigationController?.popViewController(animated: true)
    }
    func deleteAddress(at indexPath: IndexPath) {
        let addressToDelete = addresses[indexPath.row]
        
        CoreDataManager.shared.deleteAddress(address: addressToDelete)
        
        addresses.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

extension PickAddressViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickAddressTableViewCell", for: indexPath) as! PickAddressTableViewCell
        let address = addresses[indexPath.row]
        cell.configure(with: address)
        cell.onDeleteTapped = { [weak self] in
            guard let self = self else { return }
            self.deleteAddress(at: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAddress = addresses[indexPath.row]
    }
}
extension PickAddressViewController: BottomSheetAddAddressDelegate {
    func didAddNewAddress() {
        fetchAddresses()
    }
}
