//
//  HistoryOrderDetailViewModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 13/11/24.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class HistoryOrderDetailViewModel: BaseViewModel {
    
    var networkManager = NetworkManager.shared

    var historyDetailModel = BehaviorRelay<HistoryDetailModel?>(value: nil)
    var disposeBag = DisposeBag()
    
    func fetchRequestData(orderID: String) {
        self.loadingState.accept(.loading)
        NetworkManager.shared.fetchRequest(endpoint: .historyDetail(orderID: orderID), epecting: HistoryDetailModel.self) { result in
            switch result {
            case .success(let data):
                print("items berhasil diambil: \(data)")
                self .loadingState.accept(.finished)
                self .historyDetailModel.accept(data)
            case .failure(let error):
                print("Terjadi error: \(error)")
                self .loadingState.accept(.failed)
            }
            
        }
    }
}
