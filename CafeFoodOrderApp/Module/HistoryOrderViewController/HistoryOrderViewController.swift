//
//  HistoryOrderViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 21/10/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import SkeletonView


class HistoryOrderViewController: BaseViewController {

    @IBOutlet weak var toolBarView: ToolBarView!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = HistoryOrderViewModel()
    var historyData: [HistoryData] = []
    lazy var errorStateView = ErrorViewController(frame: tableView.frame)
    lazy var emptyStateView = EmptyView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindingData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
        viewModel.fetchRequestData()
    }
    
    
    func setup() {
        let nib = UINib(nibName: "HistoryOrderTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HistoryOrderTableViewCell")

        toolBarView.setup(title: "History Order")
        toolBarView.rightButton.isHidden = false
        toolBarView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func hideNavigationBar() {
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isTranslucent = true
    }
    func updateEmptyStateView() {
        let isEmpty = historyData.isEmpty

        // Tampilkan atau sembunyikan empty state
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

    
    func bindingData() {
        viewModel.loadingState.asObservable().subscribe(onNext: { [weak self] loading in
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
        
        viewModel.historyDataModel.asObservable().subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            guard let data = data else { return }
            self.historyData = data.data

            DispatchQueue.main.async {
                self.updateEmptyStateView()

                self.tableView.reloadData()
            }
        }).disposed(by: bag)
        
    }
}

extension HistoryOrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryOrderTableViewCell", for: indexPath) as? HistoryOrderTableViewCell else {
                return UITableViewCell()
            }
            
            let historyItem = historyData[indexPath.row]
            cell.configure(data: historyItem)
            
            cell.onSelectedOrder = { [weak self] in
                guard let self = self else { return }
                self.navigateToDashboard()
            }
            
            cell.onSelectedCategory = { [weak self] selectedData in
                guard let self = self else { return }
                self.navToDetail(selectedData)
            }

        cell.cancelButtonTapped = { [weak self] in
                    guard let self = self else { return }
                    self.cancelOrder(at: indexPath)
                }
            
            return cell
        }
    func navigateToDashboard() {
        if let mainTabBarController = self.tabBarController as? MainTabBarController {
            mainTabBarController.switchToTab(type: .dashboard)
        }
    }
    
    func navToDetail(_ data: HistoryData) {
        let vc = HistoryOrderDetailViewController()
        vc.orderID = data.orPlatformID
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension HistoryOrderViewController: FilterHistoryDelegate {
    func applyFilter(status: String?) {
        if let status = status {
            // Filter data: hanya tampilkan data dengan status yang cocok
            historyData = viewModel.historyDataModel.value?.data.filter { $0.orStatus?.lowercased() == status } ?? []
        } else {
            // Tampilkan semua data jika tidak ada filter
            bindingData() // Memanggil ulang data asli
        }
        tableView.reloadData()
    }
}

extension HistoryOrderViewController {
    
    
    func cancelOrder(at indexPath: IndexPath) {
            // Pastikan indeks valid
            guard indexPath.row < historyData.count else { return }
            
            // Perbarui status di model data
            historyData[indexPath.row].orStatus = "Cancelled"
            
            // Hapus data dari array
            historyData.remove(at: indexPath.row)
            
            // Perbarui tabel dengan animasi
            tableView.performBatchUpdates({
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }, completion: { _ in
                print("Pesanan berhasil dibatalkan dan dihapus dari tabel.")
            })
        }
    func navigateBackToHistory() {
            self.navigationController?.popViewController(animated: true)
        }
}

extension HistoryOrderViewController: SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Jumlah baris skeleton yang ingin ditampilkan
        return 5
    }
    
    func numberOfSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> String {
        // Identifier untuk cell yang akan digunakan sebagai skeleton
        return "HistoryOrderTableViewCell"
    }
}

extension HistoryOrderViewController:ToolBarViewDelegate {
    func addTapButton() {
        
    }
    
    func rightButton() {
        let vc = FilterHistoryViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    
}
