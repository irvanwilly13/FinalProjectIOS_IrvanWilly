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

class HistoryOrderViewController: UIViewController {
    
    @IBOutlet weak var toolBarView: ToolBarView!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = HistoryOrderViewModel()
    let disposeBag = DisposeBag()
    var historyData: [HistoryData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindingData()
        //hideNavigationBar()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }

    
    func setup() {
        let nib = UINib(nibName: "HistoryOrderTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HistoryOrderTableViewCell")
        
        toolBarView.setup(title: "History Order")

        tableView.delegate = self
        tableView.dataSource = self
    }
    func hideNavigationBar() {
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isTranslucent = true
        //self.hidesBottomBarWhenPushed = false
    }
    func bindingData() {
            viewModel.loadingState.asObservable().subscribe(onNext: { [weak self] loading in
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
            }).disposed(by: disposeBag)

        viewModel.historyDataModel.asObservable().subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            guard let data = data else { return }
            self.historyData = data.data  // Perbaikan di sini
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
        
        viewModel.fetchRequestData()
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
        let data = historyData[indexPath.row]
        cell.configure(data: data)
        return cell
    }
}


