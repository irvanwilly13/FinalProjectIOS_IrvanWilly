//
//  PromotionViewModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 17/11/24.
//

import RxSwift
import RxRelay
import RxCocoa

class PromotionViewModel: BaseViewModel {
    
    var networkManager = NetworkManager.shared
    var promotionAppData = BehaviorRelay<[PromotionData]>(value: [])
    
    func fetchRequestData() {
        self.loadingState.accept(.loading)
        NetworkManager.shared.fetchRequest(endpoint: .promotion, epecting: PromotionModel.self) { result in
            switch result {
            case .success(let data):
                print("items berhasil diambil: \(data)")
                self .loadingState.accept(.finished)
                self .promotionAppData.accept(data.data)
            case .failure(let error):
                print("Terjadi error: \(error)")
                self .loadingState.accept(.failed)
            }
        }
    }
}
