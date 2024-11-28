//
//  CancelOrderViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 21/11/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import SkeletonView

class CancelOrderViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var coachMarkView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    let viewModel = CancelOrderViewModel()
    var orderID: String?
    var onClickCancel: (() -> Void)?
    
    let reasons = [
        "Metode pembayaran tidak tersedia",
        "Perlu menambahkan voucher untuk pesanan tersebut",
        "Perlu mengubah pesanan",
        "Ingin Menambah pesanan",
        "Tidak perlu lagi",
        "Pesanan tidak sesuai",
        "Cafe meminta pembatalan pesanan"
    ]
    
    var selectedReasonIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSubmitButton()
        bindingData()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "CancelOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "CancelOrderTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        coachMarkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCoachMark)))
        containerView.makeCornerRadius(16, maskedCorner: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
    }
    
    private func setupSubmitButton() {
        submitButton.isEnabled = false
        submitButton.backgroundColor = UIColor.lightGray
        submitButton.layer.cornerRadius = 8
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    func bindingData() {
        viewModel.loadingState.asObservable().subscribe(onNext: { [ weak self ] loading in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch loading {
                case .loading:
                    print("loading")
                    self.tableView.showAnimatedGradientSkeleton()
                case .failed:
                    print("failed")
                    self.tableView.hideSkeleton()
                case .finished:
                    self.tableView.hideSkeleton()
                    print("finished")
                default:
                    break
                }
            }
        }).disposed(by: bag)
        
        viewModel.cancelAppData.asObservable().subscribe(onNext: { [ weak self ] data in
            guard let self = self else { return }
            guard let data = data else { return }
            
            UIView.animate(withDuration: 0.3) {
                self.onClickCancel?()
                self.dismiss(animated: true, completion: nil)
            }
        }).disposed(by: bag)
    }
    @objc func tapCoachMark() {
        UIView.animate(withDuration: 0.3) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func submitButtonTapped() {
        if let selectedIndex = selectedReasonIndex {
            print("Selected reason: \(reasons[selectedIndex])")
            if let orderID = orderID {
                viewModel.fetchRequestCancelData(orderID: orderID)
            }
            dismiss(animated: true, completion: nil)
        }
    }
}

extension CancelOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CancelOrderTableViewCell", for: indexPath) as? CancelOrderTableViewCell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = reasons[indexPath.row]
        cell.selectButton.isSelected = (selectedReasonIndex == indexPath.row)
        cell.selectButton.setImage(UIImage(systemName: cell.selectButton.isSelected ? "largecircle.fill.circle" : "circle"), for: .normal)
        if cell.selectButton.isSelected {
            cell.selectButton.tintColor = UIColor.orange
        } else {
            cell.selectButton.tintColor = UIColor.lightGray
        }
        
        cell.selectButton.tag = indexPath.row
        cell.selectButton.addTarget(self, action: #selector(selectReason(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func selectReason(_ sender: UIButton) {
        selectedReasonIndex = sender.tag
        tableView.reloadData()
        
        submitButton.isEnabled = true
        submitButton.isEnabled = selectedReasonIndex != nil
        submitButton.backgroundColor = submitButton.isEnabled ? UIColor.orange : UIColor.lightGray
    }
}
