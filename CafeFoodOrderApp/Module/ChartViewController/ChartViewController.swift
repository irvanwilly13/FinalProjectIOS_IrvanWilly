//
//  ChartViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 21/10/24.
//

import UIKit
import SkeletonView
import RxSwift
import RxCocoa
import RxRelay
import SnapKit
import Firebase
import FirebaseAnalytics

class ChartViewController: UIViewController {
    
    @IBOutlet weak var containerTotalLabel: UIView!
    @IBOutlet weak var toolBarView: ToolBarView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var checkOutButton: UIButton!
    
    @IBOutlet weak var containerPaymentView: UIView!
    @IBOutlet weak var subtotalStackView: UIStackView!
    @IBOutlet weak var deliverStackView: UIStackView!
    
    private var selectedIndexPath: IndexPath?
    
    let disposeBag = DisposeBag()
    var viewModel = ChartViewModel()
    
    private var cartItems: [(food: ProductFood, quantity: Int)] = []
    lazy var emptyStateView = EmptyView()
    lazy var errorStateView = ErrorViewController()
    
    
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
    var totalAmount: Double {
        let totalText = totalLabel.text?.replacingOccurrences(of: "Rp. ", with: "").replacingOccurrences(of: ",", with: ".") ?? "0"
        return Double(totalText) ?? 0.0
    }
    var subtotalAmount: Double = 0.0
    
    var deliveryFee: Double = 0.0
    private var defaultDeliveryFee: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTotalLabelAppearance()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCartItem()
        hideNavigationBar()
    }
    
    func setup() {
        let nib = UINib(nibName: "ChartViewTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ChartViewTableViewCell")
        
        checkOutButton.addTarget(self, action: #selector(actionToCheckOut), for: .touchUpInside)
        
        toolBarView.setup(title: "Chart")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func setupTotalLabelAppearance() {
        containerTotalLabel.layer.cornerRadius = 8
        containerTotalLabel.layer.masksToBounds = false
        
        containerTotalLabel.layer.shadowColor = UIColor.black.cgColor
        containerTotalLabel.layer.shadowOpacity = 0.3
        containerTotalLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        containerTotalLabel.layer.shadowRadius = 6
    }
    
    @objc func actionToCheckOut() {
        
        Analytics.logEvent("checkout_button_tapped", parameters: [
            "total_amount": totalAmount,
            "item_count": cartItems.count
        ])
        
        let vc = OrderPageViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.cartItems = cartItems
        vc.subtotalAmount = subtotalAmount
        vc.deliveryFeeAmount = deliveryFee
        vc.totalAmount = totalAmount
        
        vc.onCheckoutCompleted = { [weak self] in
            guard let self = self else { return }
            
            self.cartItems.removeAll()
            self.tableView.reloadData()
            self.updateEmptyStateView()
            self.updateTotalPrice()
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func loadCartItem() {
        cartItems = CartService.shared.getCartItem()
        tableView.reloadData()
        updateEmptyStateView()
        updateTotalPrice()
    }
    
    func updateTotalPrice() {
        let subtotal = cartItems.reduce(0.0) { result, item in
            result + (Double(item.quantity) * Double((item.food.price ?? 0)))
        }
        
        subtotalAmount = subtotal
        
        let total = subtotal
        
        subTotalLabel.text = String(format: "Rp. %.2f", subtotal)
        deliveryFeeLabel.text = String(format: "Free Delivery", deliveryFee)
        
        totalLabel.text = String(format: "Rp. %.2f", total)
    }
    func hideNavigationBar() {
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.isNavigationBarHidden = true
        self.hidesBottomBarWhenPushed = false
    }
    
    func updateEmptyStateView() {
        tableView.isHidden = cartItems.isEmpty
        containerTotalLabel.isHidden = cartItems.isEmpty
        subtotalStackView.isHidden = cartItems.isEmpty
        deliverStackView.isHidden = cartItems.isEmpty
        checkOutButton.isHidden = cartItems.isEmpty
        shouldShowErrorView(status: cartItems.isEmpty)
    }
    
    func shouldShowErrorView(status: Bool) {
        switch status {
        case true:
            if !view.subviews.contains(emptyStateView) {
                view.addSubview(emptyStateView)
                emptyStateView.snp.makeConstraints {
                    $0.top.equalTo(toolBarView.snp.bottom)
                    $0.horizontalEdges.equalToSuperview()
                    $0.bottom.equalToSuperview()
                }
            } else {
                emptyStateView.isHidden = false
                
            }
        case false:
            if view.subviews.contains(emptyStateView) {
                emptyStateView.isHidden = true
            }
        }
    }
}

extension ChartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChartViewTableViewCell", for: indexPath) as! ChartViewTableViewCell
        
        let item = cartItems[indexPath.row]
        cell.configure(with: item.food, quantity: item.quantity)
        cell.delegate = self
        
        // Highlight the selected row
        cell.containerView.backgroundColor = selectedIndexPath == indexPath ? .lightGray : .white
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Toggle the selection state for the selected row
        if selectedIndexPath == indexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        tableView.reloadData()
    }
}
extension ChartViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> String {
        return "ChartViewTableViewCell"
    }
}

extension ChartViewController: FoodChartItemTableViewCellDelegate {
    func cartItemCell(didTapAddFor food: ProductFood) {
        CartService.shared.addToCart(food: food)
        loadCartItem()
        updateTotalPrice()
    }
    
    func cartItemCell(didtapRemoveFor food: ProductFood) {
        CartService.shared.removeFromCart(food: food)
        loadCartItem()
        updateTotalPrice()
    }
    
    func cartItemCell(didTapCancelFor food: ProductFood) {
        // Hapus item dari CartService
        CartService.shared.removeFromCart(food: food)
        
        // Muat ulang data cart
        loadCartItem()
        updateTotalPrice()
    }
}


