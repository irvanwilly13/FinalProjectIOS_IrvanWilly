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
    }
    @objc func selectCancelledFilter() {
        selectedFilter = "cancelled"
        updateButtonStates()
    }
    
    @objc func selectPendingFilter() {
        selectedFilter = "pending" // Set filter ke pending
        updateButtonStates()
    }
    
    @objc func selectPaidFilter() {
        selectedFilter = "paid" // Set filter ke paid
        updateButtonStates()
    }
    
    @objc func resetFilter() {
        selectedFilter = nil // Tampilkan semua data
        updateButtonStates()
    }
    
    @objc func applySelectedFilter() {
        delegate?.applyFilter(status: selectedFilter) // Kirim status filter ke delegate
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
        paidButton.backgroundColor = selectedFilter == "paid" ? .systemBlue : .lightGray
        pendingButton.backgroundColor = selectedFilter == "pending" ? .systemBlue : .lightGray
        cancelledButton.backgroundColor = selectedFilter == "cancelled" ? .systemBlue : .lightGray
        viewAllButton.backgroundColor = selectedFilter == nil ? .systemBlue : .lightGray
    }
}

