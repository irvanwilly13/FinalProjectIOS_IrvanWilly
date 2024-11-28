//
//  DetailFoodViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 23/10/24.
//

import UIKit
import SkeletonView
import RxSwift
import RxCocoa
import RxRelay
import Toast
import Kingfisher
import FirebaseAnalytics

class DetailFoodViewController: BaseViewController {
    
    var data: FoodCategoryData?
    var item: ProductFood?
    var itemCount: Int = 1
    
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var toolBarView: ToolBarView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var seeReviewButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var addToChartButton: UIButton!
    
    var viewModel = DetailFoodViewModel()
    lazy var emptyStateView = EmptyView(frame: view.frame)
    lazy var errorStateView = ErrorViewController(frame: view.frame)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData()
        bindData()
    }
    
    func setup() {
        addToChartButton.addTarget(self, action: #selector(actionTap), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(increaseItemCount), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(decreaseItemCount), for: .touchUpInside)
        toolBarView.setup(title: "Detail Menu")
    }
    
    func loadData() {
        if let item = item {
            nameLabel.text = item.name
            descLabel.text = item.description
            if let price = item.price {
                let harga = String(price).convertToCurrencyWithDecimal()
                priceLabel.text = "Rp. \(harga)"
            }
            ratingLabel.text = item.rating ?? ""
            countLabel.text = "\(itemCount)"
            if let urlString = item.image, let imageUrl = URL(string: urlString) {
                imgView.kf.setImage(with: imageUrl)
            } else {
                imgView.image = UIImage(named: "errorX")
            }
        }
    }
    func showSkeleton(show: Bool) {
        if show {
            imgView.showAnimatedGradientSkeleton()
            nameLabel.showAnimatedGradientSkeleton()
            ratingLabel.showAnimatedGradientSkeleton()
            reviewLabel.showAnimatedGradientSkeleton()
            priceLabel.showAnimatedGradientSkeleton()
            countLabel.showAnimatedGradientSkeleton()
            descLabel.showAnimatedGradientSkeleton()
            addToChartButton.showAnimatedGradientSkeleton()
            minusButton.showAnimatedGradientSkeleton()
            plusButton.showAnimatedGradientSkeleton()
            seeReviewButton.showAnimatedGradientSkeleton()
            starImage.showAnimatedGradientSkeleton()
        } else {
            imgView.hideSkeleton()
            nameLabel.hideSkeleton()
            ratingLabel.hideSkeleton()
            reviewLabel.hideSkeleton()
            priceLabel.hideSkeleton()
            countLabel.hideSkeleton()
            descLabel.hideSkeleton()
            addToChartButton.hideSkeleton()
            minusButton.hideSkeleton()
            plusButton.hideSkeleton()
            seeReviewButton.hideSkeleton()
            starImage.hideSkeleton()
        }
    }
    
    func bindData() {
        if let item = item {
            viewModel.getDetailFood(id: String(item.id))
        }
        
        viewModel.detailFoodData.asObservable().subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            guard let data = data else { return }
            //self.updateEmptyStateView()
            
            print(data)
        }).disposed(by: bag)
        
        viewModel.loadingState.asObservable().subscribe(onNext: { [ weak self ] loading in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch loading {
                case .loading:
                    print("loading")
                    self.showSkeleton(show: true)
                    //self.shouldShowErrorView(status: false)
                case .failed:
                    print("failed")
                    self.showSkeleton(show: false)
                    // self.shouldShowErrorView(status: true)
                case .finished:
                    print("finished")
                    self.showSkeleton(show: false)
                    // self.shouldShowErrorView(status: false)
                default:
                    break
                }
            }
        }).disposed(by: bag)
        
    }
    func updateEmptyStateView() {
        emptyStateView.updateMessage("No items available in this chart.")
        emptyStateView.updateImage(UIImage(named: "errorX"))
        emptyStateView.containerView.backgroundColor = UIColor.lightGreyCofa
        
    }
    
    func shouldShowErrorView(status: Bool) {
        if status {
            if !view.subviews.contains(emptyStateView) {
                view.addSubview(emptyStateView)
                emptyStateView.isHidden = false
            } else {
                emptyStateView.isHidden = false
            }
        } else {
            emptyStateView.isHidden = true
        }
    }
}

extension DetailFoodViewController {
    
    @objc func actionTap() {
        if let foodItem = self.item {
            CartService.shared.addToCart(food: foodItem)
            
            if let urlString = foodItem.image, let imageUrl = URL(string: urlString) {
                imgView.kf.setImage(with: imageUrl)
            } else {
                imgView.image = UIImage(named: "errorX")
            }
            Analytics.logEvent("add_to_cart", parameters: [
                "item_name": foodItem.name,
                "item_id": foodItem.id,
                "item_price": foodItem.price ?? 0,
                "item_quantity": itemCount
            ])
            
            let toast = Toast.default(
                image: imgView.image ?? UIImage(),
                title: "OK",
                subtitle: "\(foodItem.name) telah ditambahkan ke keranjang"
            )
            toast.show()
        }
    }
    
    @objc func increaseItemCount() {
        itemCount += 1
        countLabel.text = "\(itemCount)"
    }
    
    @objc func decreaseItemCount() {
        if itemCount > 1 {
            itemCount -= 1
            countLabel.text = "\(itemCount)"
        }
    }
    
    func navigateToDashboard() {
        let vc = DashboardViewController()
        // vc.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
