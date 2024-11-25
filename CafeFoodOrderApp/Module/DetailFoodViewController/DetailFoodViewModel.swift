//
//  DetailFoodViewModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 11/11/24.
//

import Foundation
import UIKit
import RxSwift
import RxRelay
import RxCocoa

class DetailFoodViewModel: BaseViewModel {
    
    var networkManager = NetworkManager.shared
    var categoryData = BehaviorRelay<DetailFoodModel?>(value: nil)

    var detailFoodData = BehaviorRelay<DetailFoodModel?>(value: nil)
    var disposeBag = DisposeBag()
    
    func getDetailFood(id: String) {
        self.loadingState.accept(.loading)
        NetworkManager.shared.fetchRequest(endpoint: .detailFood(id: id), epecting: DetailFoodModel.self) { result in
            switch result {
            case .success(let data):
                print("items berhasil diambil: \(data)")
                self .loadingState.accept(.finished)
                self .detailFoodData.accept(data)
            case .failure(let error):
                print("Terjadi error: \(error)")
                self .loadingState.accept(.failed)
            }
            
        }
    }
}
