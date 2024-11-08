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
            setupButtons()
            resetFilters() // Awali dengan reset ke data asli
        }
        
        func setupButtons() {
            highestPriceButton.addTarget(self, action: #selector(filterHighestPrice), for: .touchUpInside)
            lowerPriceButton.addTarget(self, action: #selector(filterLowestPrice), for: .touchUpInside)
            oneStarButton.addTarget(self, action: #selector(filterOneStar), for: .touchUpInside)
            twoStarButton.addTarget(self, action: #selector(filterTwoStars), for: .touchUpInside)
            threeStarButton.addTarget(self, action: #selector(filterThreeStars), for: .touchUpInside)
            fourStarButton.addTarget(self, action: #selector(filterFourStars), for: .touchUpInside)
            applyButton.addTarget(self, action: #selector(applyFilterButton), for: .touchUpInside)
        }
        
        // Fungsi untuk mengatur ulang data ke nilai asli
        func resetFilters() {
            filteredItems = items // Pastikan selalu mulai dari data asli
        }
        
        // Filter harga tertinggi
        @objc func filterHighestPrice() {
            resetFilters()
//            filteredItems = filteredItems.sorted { ($0.price ?? 0) > ($1.price ?? 0) }
        }
        
        // Filter harga terendah
        @objc func filterLowestPrice() {
            resetFilters()
//            filteredItems = filteredItems.sorted { ($0.price ?? 0) < ($1.price ?? 0) }
        }
        
        // Filter item dengan rating minimal 1 bintang
        @objc func filterOneStar() {
            resetFilters()
//            filteredItems = filteredItems.filter { $0.rating >= 1.0 }
        }
        
        // Filter item dengan rating minimal 2 bintang
        @objc func filterTwoStars() {
            resetFilters()
//            filteredItems = filteredItems.filter { $0.rating >= 2.0 }
        }
        
        // Filter item dengan rating minimal 3 bintang
        @objc func filterThreeStars() {
            resetFilters()
//            filteredItems = filteredItems.filter { $0.rating >= 3.0 }
        }
        
        // Filter item dengan rating minimal 4 bintang
        @objc func filterFourStars() {
            resetFilters()
//            filteredItems = filteredItems.filter { $0.rating >= 4.0 }
        }
        
        // Fungsi untuk menerapkan filter dan mengirim hasilnya ke delegate
        @objc func applyFilterButton() {
            delegate?.applyFilter(sortedItems: filteredItems.isEmpty ? items : filteredItems)
            dismiss(animated: true, completion: nil)
        }
    }




