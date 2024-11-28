//
//  PromotionViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 16/11/24.
//

import UIKit
import SkeletonView
import RxSwift
import RxCocoa
import RxRelay

protocol PromotionViewControllerDelegate: AnyObject {
    func didSelectPromoCode(_ promo: PromotionData)
}

class PromotionViewController: BaseViewController {
    
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var toolBarView: ToolBarView!
    
    var viewModel = PromotionViewModel()
    
    var promotions: [PromotionData] = []
    var selectedPromotion: PromotionData?
    var selectedPromoCode: String?
    var onPromoSelected: ((String) -> Void)?
    weak var delegate: PromotionViewControllerDelegate?
    
    lazy var errorStateView = ErrorViewController(frame: tableView.frame)
    lazy var emptyStateView = EmptyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindingData()
        viewModel.fetchRequestData()
    }
    func setup() {
        let nib = UINib(nibName: "PromotionTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PromotionTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        toolBarView.setup(title: "Promotions")
        
        applyButton.addTarget(self, action: #selector(applyPromoCode), for: .touchUpInside)
        
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
        
        viewModel.promotionAppData.asObservable().subscribe(onNext: {[ weak self ] data in
            guard let self = self else { return }
            let data = data.filter{
                $0.prmType == "amount" || $0.prmType == "percentage"
            }
            
            self.promotions = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.updateEmptyStateView()
            }
        }).disposed(by: bag)
        
    }
    func updateEmptyStateView() {
        let isEmpty = promotions.isEmpty
        emptyStateView.updateMessage("No promotions available.")
        emptyStateView.updateImage(UIImage(named: "errorX"))
        emptyStateView.containerView.backgroundColor = UIColor.lightGreyCofa
        
        if isEmpty {
            if !view.subviews.contains(emptyStateView) {
                view.addSubview(emptyStateView)
            }
            emptyStateView.isHidden = false
            tableView.isHidden = true
        } else {
            emptyStateView.isHidden = true
            tableView.isHidden = false
        }
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
    
    @objc func applyPromoCode() {
        guard let selectedPromoCode = selectedPromoCode,
              let selectedPromo = promotions.first(where: { $0.prmCode == selectedPromoCode }) else {
            print("No promo code selected or promo not found")
            return
        }
        delegate?.didSelectPromoCode(selectedPromo)
        navigationController?.popViewController(animated: true)
    }
}

extension PromotionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promotions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PromotionTableViewCell", for: indexPath) as? PromotionTableViewCell else {
                return UITableViewCell()
            }
            
            let promotion = promotions[indexPath.row]
            let isSelected = promotion.prmCode == selectedPromoCode
            cell.configure(data: promotion, isSelected: isSelected)
            
            cell.onPromoSelected = { [weak self] promoCode in
                self?.selectedPromoCode = promoCode
                self?.tableView.reloadData()
            }
            return cell
            }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPromoCode = promotions[indexPath.row].prmCode
        tableView.reloadData()
    }
    private func updateVoucherField() {
            NotificationCenter.default.post(name: .promoSelected, object: selectedPromoCode)
        }
}

