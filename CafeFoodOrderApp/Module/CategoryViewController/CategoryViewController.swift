//
//  CategoryViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 23/10/24.
//

import UIKit
import SkeletonView
import RxSwift
import RxCocoa
import RxRelay

class CategoryViewController: UIViewController, FilterDelegate {
    
    
    
    @IBOutlet weak var labelImgView: UIImageView!
    @IBOutlet weak var pizzaImgView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nameCategoryLabel: UILabel!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var toolBarView: ToolBarView!
    @IBOutlet weak var tableView: UITableView!
    
    var categoryFood: [ProductFood] = []
    var item: Category?
    var viewModel = CategoryViewModel()
    
    lazy var emptyStateView = EmptyView(frame: tableView.frame)
    lazy var errorStateView = ErrorViewController(frame: tableView.frame)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindingData()
        
    }
    
    func setup() {
        let nib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CategoryTableViewCell")
        filterButton.addTarget(self, action: #selector(openFilter), for: .touchUpInside)
        toolBarView.setup(title: "Category Menu")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    @objc func openFilter() {
        let filterVC = filterBottomSheetViewController()
        filterVC.items = categoryFood
        filterVC.delegate = self
        filterVC.modalPresentationStyle = .overFullScreen
        filterVC.modalTransitionStyle = .crossDissolve
        present(filterVC, animated: true, completion: nil)
    }
    
    func applyFilter(sortedItems: [ProductFood]) {
        categoryFood = sortedItems
        tableView.reloadData()
        updateEmptyStateView()
    }
    
    
    func showSkeleton(show: Bool) {
        if show {
            nameCategoryLabel.showAnimatedGradientSkeleton()
            descLabel.showAnimatedGradientSkeleton()
            pizzaImgView.showAnimatedGradientSkeleton()
            labelImgView.showAnimatedGradientSkeleton()
        } else {
            nameCategoryLabel.hideSkeleton()
            descLabel.hideSkeleton()
            pizzaImgView.hideSkeleton()
            labelImgView.hideSkeleton()
        }
    }
    
    func bindingData() {
        viewModel.loadingState.asObservable().subscribe(onNext: { [ weak self ] loading in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch loading {
                case .loading:
                    print("loading")
                    self.tableView.showAnimatedGradientSkeleton()
                    self.showSkeleton(show: true)
                    self.shouldShowErrorView(status: false)
                case .failed:
                    print("failed")
                    self.tableView.hideSkeleton()
                    self.showSkeleton(show: false)
                    self.shouldShowErrorView(status: true)
                case .finished:
                    self.tableView.hideSkeleton()
                    self.showSkeleton(show: false)
                    self.updateEmptyStateView()
                    print("finished")
                default:
                    break
                }
            }
            
        }).disposed(by: disposeBag)
        
        if let item = item {
            viewModel.fetchRequestData(type: item.name)
        }
        
        viewModel.foodAppData.asObservable().subscribe(onNext: { [ weak self ] data in
            guard let self = self else { return }
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.categoryFood = data.data.items
                self.nameCategoryLabel.text = data.data.category.name
                self.descLabel.text = data.data.category.description ?? "-"
                self.tableView.reloadData()
                self.updateEmptyStateView()
            }
        }).disposed(by: disposeBag)
    }
    
    
    func updateEmptyStateView() {
        emptyStateView.updateMessage("No items available in this category.")
        emptyStateView.updateImage(UIImage(named: "errorX"))
        emptyStateView.containerView.backgroundColor = UIColor.lightGreyCofa
        let isEmpty = categoryFood.isEmpty
        shouldShowErrorView(status: isEmpty)
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

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryFood.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        let foodItem = categoryFood[indexPath.row]
        cell.configure(with: foodItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Ambil data item yang dipilih
        let selectedFood = categoryFood[indexPath.row]
        
        // Inisialisasi DetailFoodViewController
        let vc = DetailFoodViewController()
        vc.item = selectedFood // Mengoper data ke DetailFoodViewController
        
        // Pindah ke halaman DetailFoodViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CategoryViewController: SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> String {
        let sectionType = FoodDashboardType(rawValue: indexPath.section)
        return "CategoryTableViewCell"
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 // Tampilkan 5 skeleton row
    }
}


