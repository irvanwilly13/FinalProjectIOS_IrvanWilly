//
//  filterBottomSheetViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 28/10/24.
//

import UIKit

protocol FilterDelegate: AnyObject {
    func applyFilter(sortedItems: [ProductFood])
}

class filterBottomSheetViewController: UIViewController {
    
    @IBOutlet weak var coachMarkView: UIView!
    @IBOutlet weak var highestPriceButton: UIButton!
    @IBOutlet weak var lowerPriceButton: UIButton!
    @IBOutlet weak var oneStarButton: UIButton!
    @IBOutlet weak var twoStarButton: UIButton!
    @IBOutlet weak var threeStarButton: UIButton!
    @IBOutlet weak var fourStarButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    
    weak var delegate: FilterDelegate?
    var items: [ProductFood] = [] // Item yang akan difilter
    var filteredItems: [ProductFood] = [] // Hasil filter sementara
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupButtons()
        resetFilters() // Awali dengan reset ke data asli
    }
    
    func setupButtons() {
        highestPriceButton.addTarget(self, action: #selector(filterHighestPrice), for: .touchUpInside)
        lowerPriceButton.addTarget(self, action: #selector(filterLowestPrice), for: .touchUpInside)
        applyButton.addTarget(self, action: #selector(applyFilterButton), for: .touchUpInside)
    }
    
    // Fungsi untuk mengatur ulang data ke nilai asli
    func resetFilters() {
        filteredItems = items // Pastikan selalu mulai dari data asli
    }
    
    @objc func filterHighestPrice() {
        resetFilters()
        filteredItems = filteredItems.sorted { ($0.price ?? 0) > ($1.price ?? 0) }
    }
    @objc func filterLowestPrice() {
        resetFilters()
        filteredItems = filteredItems.sorted { ($0.price ?? 0) < ($1.price ?? 0) }
    }
    
    
    // Fungsi untuk menerapkan filter dan mengirim hasilnya ke delegate
    @objc func applyFilterButton() {
        delegate?.applyFilter(sortedItems: filteredItems)
        dismiss(animated: true, completion: nil)
    }
    func configure() {
        coachMarkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCoachMark)))
    }
    @objc func tapCoachMark() {
        UIView.animate(withDuration: 0.3) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}




