//
//  HistoryOrderDetailViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 13/11/24.
//

import UIKit
import SkeletonView
import RxSwift
import RxCocoa
import RxRelay

enum HistoryOrderType: Int, CaseIterable {
    case orderHistory = 0
    case paymentDetail = 1
    case orderAgain = 2
}

class HistoryOrderDetailViewController: UIViewController, ErrorViewControllerDelegate {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var toolBarView: ToolBarView!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = HistoryOrderDetailViewModel()
    let disposeBag = DisposeBag()
    
    private var refreshControl = UIRefreshControl()
    lazy var errorStateView = ErrorViewController(frame: tableView.frame)
    lazy var emptyStateView = EmptyView()
    
    
    var detailData: HistoryDetailData?
    var orderID: String?
    
    var isFrom: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
        bindingData()
        statusLabel.isSkeletonable = true
        orderIdLabel.isSkeletonable = true
        toolBarView.rightButton.isHidden = false
        
        toolBarView.rightButton.setImage(UIImage(named: "download_receipt_icon"), for: .normal)

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    func setup() {
        toolBarView.rightButton.addTarget(self, action: #selector(downloadReceiptTapped), for: .touchUpInside)

    }
    
    @objc func downloadReceiptTapped() {
        guard let orderID = orderID else { return }
        captureScreenshotAndSaveAsPDF(orderID: orderID)
    }

    func captureScreenshotAndSaveAsPDF(orderID: String) {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        let pdfData = createPDF(from: image)
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let pdfURL = documentDirectory.appendingPathComponent("\(orderID)_receipt.pdf")
        
        do {
            try pdfData.write(to: pdfURL)
            
            
            print("PDF berhasil disimpan di: \(pdfURL)")
            
            let alertController = UIAlertController(title: "Sukses", message: "Tanda terima telah disimpan sebagai PDF.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
            
            sharePDF(pdfURL: pdfURL)
            
        } catch {
            print("Gagal menyimpan PDF: \(error.localizedDescription)")
        }
    }

    func createPDF(from image: UIImage) -> Data {
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height), nil)
        UIGraphicsBeginPDFPage()
        
        image.draw(at: CGPoint(x: 0, y: 0))
        
        UIGraphicsEndPDFContext()
        
        return pdfData as Data
    }

    func sharePDF(pdfURL: URL) {
        let activityController = UIActivityViewController(activityItems: [pdfURL], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = view
        present(activityController, animated: true)
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "OrderHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderHistoryTableViewCell")
        tableView.register(UINib(nibName: "PaymentDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "PaymentDetailTableViewCell")
        tableView.register(UINib(nibName: "OrderAgainTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderAgainTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        toolBarView.setup(title: "History Detail")
        
        if let isFrom = isFrom {
            toolBarView.backButton.isHidden = true
            toolBarView.rightButton.isHidden = true
        }
    }
    func configure(data: HistoryDetailData?) {
        statusLabel.text = data?.orStatus?.uppercased()
        orderIdLabel.text = data?.orPlatformID
    }
    
    func bindingData() {
        viewModel.loadingState.asObservable().subscribe(onNext: { [weak self] loading in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch loading {
                case .loading:
                    print("loading")
                    self.tableView.showAnimatedGradientSkeleton()
                    self.showSkeletonView(true)
                    self.shouldShowErrorView(status: false)
                case .failed:
                    print("failed")
                    self.tableView.hideSkeleton()
                    self.showSkeletonView(false)
                    self.shouldShowErrorView(status: true)
                case .finished:
                    self.tableView.hideSkeleton()
                    self.showSkeletonView(false)
                    self.shouldShowErrorView(status: false)
                    print("finished")
                default:
                    break
                }
            }
        }).disposed(by: disposeBag)
        
        viewModel.historyDetailModel.asObservable().subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            guard let data = data else { return }
            self.detailData = data.data
            
            DispatchQueue.main.async {
                self.configure(data: self.detailData)
                self.updateEmptyStateView()
                self.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
        
        if let orderID = orderID {
            viewModel.fetchRequestData(orderID: orderID)
        }
    }
    func updateEmptyStateView() {
        let isEmpty = detailData?.details.isEmpty ?? true
        
        tableView.isHidden = isEmpty
        emptyStateView.isHidden = !isEmpty
        
        if isEmpty && !view.subviews.contains(emptyStateView) {
            view.addSubview(emptyStateView)
            emptyStateView.frame = tableView.frame
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
    
    func presentBottomSheetReview() {
        let bottomSheetVC = BottomSheetReview()
        
        bottomSheetVC.modalPresentationStyle = .overCurrentContext
        bottomSheetVC.modalTransitionStyle = .coverVertical
        self.present(bottomSheetVC, animated: true, completion: nil)
    }
    func buttonTap() {
        
    }
    func hideNavigationBar() {
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.hidesBottomBarWhenPushed = false
    }
}

extension HistoryOrderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HistoryOrderType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let historyOrder = HistoryOrderType(rawValue: section) else { return 0 }
        switch historyOrder {
        case .orderHistory:
            let countData = detailData?.details.first?.odProducts.count ?? 0
            return countData
        case .paymentDetail:
            return 1
        case .orderAgain:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = HistoryOrderType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch cellType {
        case .orderHistory:
            guard let data = detailData else { return  UITableViewCell()}
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHistoryTableViewCell", for: indexPath) as? OrderHistoryTableViewCell else {
                return UITableViewCell()
            }
            let orderDetail = data.details.first?.odProducts[indexPath.row]
            let isFirstCell = indexPath.row == 0
            cell.configure(data: orderDetail, isFirstCell: isFirstCell)
            return cell
            
        case .paymentDetail:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentDetailTableViewCell", for: indexPath) as? PaymentDetailTableViewCell else {
                return UITableViewCell()
            }
            guard let data = detailData else { return UITableViewCell() }
            cell.configure(data: data)
            return cell
        case .orderAgain:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderAgainTableViewCell", for: indexPath) as? OrderAgainTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(status: detailData?.orStatus)
            
            cell.cancelButtonTapped = { [weak self] in
                guard let self = self else { return }
                self.navigateToCancelOrder()
            }
            
            cell.orderAgainButtonTapped = { [weak self] in
                guard let self = self else { return }
                self.navigateToDashboard()
            }
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func navigateToDashboard() {
        self.tabBarController?.selectedIndex = 0
        if let navigationController = self.tabBarController?.viewControllers?[1] as? UINavigationController {
            navigationController.popToRootViewController(animated: false)
        }
    }
    
    private func navigateToCancelOrder() {
        let cancelOrderVC = CancelOrderViewController()
        cancelOrderVC.orderID = orderID
        cancelOrderVC.onClickCancel = {
            if let orderID = self.orderID {
                self.viewModel.fetchRequestData(orderID: orderID)
            }
        }
        cancelOrderVC.modalPresentationStyle = .overFullScreen
        cancelOrderVC.modalTransitionStyle = .crossDissolve
        self.present(cancelOrderVC, animated: true, completion: nil)
    }
}
extension HistoryOrderDetailViewController {
    func showSkeletonView(_ show: Bool) {
        if show {
            statusLabel.showAnimatedGradientSkeleton()
            orderIdLabel.showAnimatedGradientSkeleton()
        } else {
            statusLabel.hideSkeleton()
            orderIdLabel.hideSkeleton()
        }
    }
    func cancelOrder() {
        detailData?.orStatus = "Cancelled"
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print("Pesanan dibatalkan.")
    }
    func navigateToPayment() {
        print("Navigasi ke halaman pembayaran")
    }
}

extension HistoryOrderDetailViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        guard let historyOrder = HistoryOrderType(rawValue: indexPath.section) else { return "" }
        switch historyOrder {
        case .orderHistory:
            return "OrderHistoryTableViewCell"
        case .paymentDetail:
            return "PaymentDetailTableViewCell"
        case .orderAgain:
            return "OrderAgainTableViewCell"
        }
    }
}
