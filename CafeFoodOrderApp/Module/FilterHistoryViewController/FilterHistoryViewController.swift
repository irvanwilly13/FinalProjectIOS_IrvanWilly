//
//  FilterHistoryViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 17/11/24.
//

import UIKit
protocol FilterHistoryDelegate: AnyObject {
    func applyFilter(status: String?)
}

class FilterHistoryViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cancelledButton: UIButton!
    @IBOutlet weak var coachMarkView: UIView!
    @IBOutlet weak var viewAllButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var pendingButton: UIButton!
    @IBOutlet weak var paidButton: UIButton!
    
    weak var delegate: FilterHistoryDelegate?
    
    private var selectedFilter: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        configure()
    }
    func configure() {
        coachMarkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCoachMark)))
    }
    @objc func tapCoachMark() {
        UIView.animate(withDuration: 0.3) {
            self.dismiss(animated: true, completion: nil)
        }
    }

    func setupButtons() {
        cancelledButton.addTarget(self, action: #selector(selectCancelledFilter), for: .touchUpInside)
        paidButton.addTarget(self, action: #selector(selectPaidFilter), for: .touchUpInside)
        pendingButton.addTarget(self, action: #selector(selectPendingFilter), for: .touchUpInside)
        viewAllButton.addTarget(self, action: #selector(resetFilter), for: .touchUpInside)
        applyButton.addTarget(self, action: #selector(applySelectedFilter), for: .touchUpInside)
        containerView.makeCornerRadius(16, maskedCorner: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    @objc func selectCancelledFilter() {
        selectedFilter = "cancelled"
        updateButtonStates()
    }
    
    @objc func selectPendingFilter() {
        selectedFilter = "pending"
        updateButtonStates()
    }
    
    @objc func selectPaidFilter() {
        selectedFilter = "paid"
        updateButtonStates()
    }
    
    @objc func resetFilter() {
        selectedFilter = nil
        updateButtonStates()
    }
    
    @objc func applySelectedFilter() {
        delegate?.applyFilter(status: selectedFilter)
        UIView.animate(withDuration: 0.3) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func updateButtonStates() {
        paidButton.isSelected = selectedFilter == "paid"
        pendingButton.isSelected = selectedFilter == "pending"
        cancelledButton.isSelected = selectedFilter == "cancelled"
        viewAllButton.isSelected = selectedFilter == nil
        
        // Ubah warna tombol sesuai dengan status
        paidButton.backgroundColor = selectedFilter == "paid" ? .lightGray : .clear
        pendingButton.backgroundColor = selectedFilter == "pending" ? .lightGray : .clear
        cancelledButton.backgroundColor = selectedFilter == "cancelled" ? .lightGray : .clear
        viewAllButton.backgroundColor = selectedFilter == nil ? .lightGray : .clear
    }
}

