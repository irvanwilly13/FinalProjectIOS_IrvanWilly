//
//  OrderPageViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 11/11/24.
//

import UIKit
import SkeletonView
import RxSwift
import RxCocoa
import RxRelay
import CoreData

enum OrderPageType: Int, CaseIterable {
    case addressItem = 0
    case detailOrder
    case promoCode
    case orderSummary
}

class OrderPageViewController: BaseViewController {
    
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var toolBarView: ToolBarView!
    
    var onCheckoutCompleted: (() -> Void)?
    
    var address: AddressModel?
    var selectedPromoCode: String? // Untuk menyimpan promo code yang dipilih
    var promotions: [PromotionData] = [] // Menyimpan daftar promo
    
    
    lazy var errorStateView = ErrorViewController(frame: tableView.frame)
    var viewModel = OrderPageViewModel()
    
    var cartItems: [(food: ProductFood, quantity: Int)] = []
    var orderItems: [OrderItem] {
        return cartItems.map { item in
            OrderItem(
                id: item.food.id,
                name: item.food.name,
                price: Int(item.food.price ?? 0),
                quantity: item.quantity,
                image: item.food.image ?? ""
            )
        }
    }
    
    var subtotalAmount: Double = 0.0
    var taxAmount: Double = 0.0
    var deliveryFeeAmount: Double = 0.0
    var totalAmount: Double = 0.0
    var discountAmount: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindingData()
        fetchAddressData()
        
    }
    func fetchAddressData() {
        // Mengambil data alamat dari CoreDataManager
        if let fetchedAddress = CoreDataManager.shared.fetchAddresses().first {
            address = fetchedAddress
        } else {
            print("No address found")
        }
        tableView.reloadData()
    }
    
    func bindingData() {
        viewModel.loadingState.asObservable().subscribe(onNext: { [ weak self ] loading in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch loading {
                case .loading:
                    print("loading")
                    self.tableView.showAnimatedGradientSkeleton()
                    self.shouldShowErrorView(status: false)
                case .failed:
                    print("failed")
                    self.tableView.hideSkeleton()
                    self.shouldShowErrorView(status: true)
                case .finished:
                    self.tableView.hideSkeleton()
                    self.shouldShowErrorView(status: false)
                    print("finished")
                default:
                    break
                }
            }
            
        }).disposed(by: bag)
        
        viewModel.chartAppData.asObservable().subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            guard let data = data else { return }
            DispatchQueue.main.async {
                let token = data.transaction.token
                
                let vc = PaymentMidTransViewController()
                vc.token = token
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
                
                
                // self.tableView.reloadData()
            }
            
            
            
        } ).disposed(by: bag)
    }
    
    func createOrder() {
        //        discountAmount = 0.0
        //
        //        if let selectedPromo = selectedPromoCode,
        //           let promo = promotions.first(where: { $0.prmCode == selectedPromo }) {
        //            if promo.prmType == "amount" {
        //                // Diskon berdasarkan jumlah tetap
        //                discountAmount = Double(promo.prmValue)
        //            } else if promo.prmType == "percentage" {
        //                // Diskon berdasarkan persentase dari subtotal
        //                discountAmount = (subtotalAmount * Double(promo.prmValue)) / 100.0
        //            }
        //        }
        //
        //        // Pastikan diskon tidak melebihi subtotal
        //            discountAmount = min(discountAmount, subtotalAmount)
        
        var promo: [String] = []
        if let item = selectedPromoCode {
            promo.append(item)
        }
        let param = CreateOrderParam(
            email: "test@gmail.com",
            items: orderItems,
            amount: Int(totalAmount),
            promoCode: promo
            
        )
        viewModel.fetchRequestData(param: param)
    }
    
    func setup() {
        
        tableView.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressTableViewCell")
        tableView.register(UINib(nibName: "DetailOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailOrderTableViewCell")
        tableView.register(UINib(nibName: "OrderSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderSummaryTableViewCell")
        tableView.register(UINib(nibName: "PromotionCodeTableViewCell", bundle: nil), forCellReuseIdentifier: "PromotionCodeTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        paymentButton.addTarget(self, action: #selector(actionPaymentButton), for: .touchUpInside)
        totalPrice.text = String(format: "Rp. %.2f", totalAmount)
        toolBarView.setup(title: "Detail Order")
        
    }
    func navigateToPromotions() {
        let promoVC = PromotionViewController()
        promoVC.delegate = self // Tetapkan delegate
        promoVC.selectedPromoCode = selectedPromoCode // Kirim promo code yang saat ini dipilih
        navigationController?.pushViewController(promoVC, animated: true)
    }
    
    @objc func actionPaymentButton() {
        createOrder()
        CartService.shared.clearCart()
            
            // Panggil closure untuk memperbarui keranjang di halaman sebelumnya
            onCheckoutCompleted?()
    }
    func shouldShowErrorView(status: Bool) {
        switch status {
        case true:
            if !view.subviews.contains(errorStateView) {
                view.addSubview(errorStateView)
            } else {
                errorStateView.isHidden = false
            }
        case false:
            if view.subviews.contains(errorStateView) {
                errorStateView.isHidden = true
            }
        }
    }
    
    
}

extension OrderPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return OrderPageType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let orderType = OrderPageType(rawValue: section) else {
            return 0
        }
        
        switch orderType {
        case .addressItem:
            return 1
        case .detailOrder:
            return orderItems.count
        case .promoCode:
            return 1
        case .orderSummary:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let orderType = OrderPageType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch orderType {
        case .addressItem:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as? AddressTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(
                with: "Irvan Willy",
                phoneNumber: "081808370321",
                address: """
                \(address?.alamat ?? "jl. Boulevard Raya"), \(address?.kabupaten ?? "Jakarta Utara"), \(address?.profinsi ?? "DKI Jakarta")
                \(address?.kodePos ?? "14045")
                """
            )
            cell.onChangeAddressTapped = { [weak self] in
                guard let self = self else { return }
                let pickAddressVC = PickAddressViewController()
                pickAddressVC.delegate = self
                self.navigationController?.pushViewController(pickAddressVC, animated: true)
            }
            return cell
        case .detailOrder:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailOrderTableViewCell", for: indexPath) as? DetailOrderTableViewCell else {
                return UITableViewCell()
            }
            
            // Ambil item dari orderItems berdasarkan indexPath.row
            let item = cartItems[indexPath.row]
            let totalPrice = Double(item.quantity) * Double(item.food.price ?? 0)
            
            cell.configure(
                with: item.food.name,
                price: String(format: "Rp. %.2f", Double(item.food.price ?? 0)),
                amount: "\(item.quantity) item",
                totalPrice: String(format: "Rp. %.2f", totalPrice),
                imageName: item.food.image ?? "" // Sesuaikan dengan nama atribut yang benar
            )
            return cell
            
        case .promoCode:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PromotionCodeTableViewCell", for: indexPath) as? PromotionCodeTableViewCell ?? UITableViewCell()
            (cell as? PromotionCodeTableViewCell)?.configure(with: "Enter voucher code", selectedPromoCode: selectedPromoCode)
            (cell as? PromotionCodeTableViewCell)?.onNavigateToPromotions = { [weak self] in
                self?.navigateToPromotions()
            }
            return cell
            
            
            
        case .orderSummary:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "OrderSummaryTableViewCell",
                for: indexPath
            ) as? OrderSummaryTableViewCell else {
                return UITableViewCell()
            }
            
            // Gunakan PromotionData untuk menghitung diskon sementara
            var displayDiscountAmount: Double = 0.0
            var displayTotalAmount: Double = subtotalAmount + deliveryFeeAmount
            
            if let selectedPromo = selectedPromoCode,
               let promo = promotions.first(where: { $0.prmCode == selectedPromo }) {
                if promo.prmType == "amount" {
                    displayDiscountAmount = Double(promo.prmValue)
                } else if promo.prmType == "percentage" {
                    displayDiscountAmount = (subtotalAmount * Double(promo.prmValue)) / 100.0
                }
                
                // Pastikan diskon tidak lebih besar dari subtotal
                displayDiscountAmount = min(displayDiscountAmount, subtotalAmount)
                displayTotalAmount -= displayDiscountAmount
            }
            
            // Konfigurasi ringkasan order dengan gimmick diskon
            cell.configure(
                total: String(format: "Rp. %.2f", displayTotalAmount),
                discount: String(format: "-Rp. %.2f", displayDiscountAmount),
                shipping: String(format: "Free Delivery", deliveryFeeAmount),
                subTotal: String(format: "Rp. %.2f", subtotalAmount)
            )
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension OrderPageViewController: ErrorViewControllerDelegate {
    func buttonTap() {
        
    }
    
    
}
extension OrderPageViewController: PromotionViewControllerDelegate {
    func didSelectPromoCode(_ promo: PromotionData) {
        selectedPromoCode = promo.prmCode
        promotions.append(promo) // Pastikan promo tersimpan di daftar promo
        tableView.reloadData()
    }
}
extension OrderPageViewController: PickAddressViewControllerDelegate {
    func didSelectAddress(_ address: AddressModel) {
        self.address = address // Simpan alamat yang dipilih
        tableView.reloadSections([OrderPageType.addressItem.rawValue], with: .automatic)
    }
}
