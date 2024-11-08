//
//  CategoryViewModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 23/10/24.
//

import Foundation

import RxSwift
import RxRelay
import RxCocoa

class CategoryViewModel: BaseViewModel {
    
    var networkManager = NetworkManager.shared
    var categoryData = BehaviorRelay<FoodCategoryData?>(value: nil)

    var foodAppData = BehaviorRelay<FoodCategoryModel?>(value: nil)
    var disposeBag = DisposeBag()
    
    func fetchRequestData(type: String) {
        self.loadingState.accept(.loading)
        NetworkManager.shared.fetchRequest(endpoint: .getByCategory(item: type), epecting: FoodCategoryModel.self) { result in
            switch result {
            case .success(let data):
                print("items berhasil diambil: \(data)")
                self .loadingState.accept(.finished)
                self .foodAppData.accept(data)
            case .failure(let error):
                print("Terjadi error: \(error)")
                self .loadingState.accept(.failed)
            }
            
        }
    }
}
