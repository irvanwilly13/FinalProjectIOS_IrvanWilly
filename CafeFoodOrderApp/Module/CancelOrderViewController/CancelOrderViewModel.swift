//
//  CancelOrderViewModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 21/11/24.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class CancelOrderViewModel: BaseViewModel {
    
    var networkManager = NetworkManager.shared
    var cancelAppData = BehaviorRelay<CancelData?>(value: nil)
    
    func fetchRequestCancelData(orderID: String) {
        self.loadingState.accept(.loading)
        NetworkManager.shared.fetchRequest(endpoint: .cancelOrder(orderID: orderID), epecting: CancelModel.self) { result in
            switch result {
            case .success(let data):
                print("items berhasil diambil: \(data)")
                self .loadingState.accept(.finished)
                self .cancelAppData.accept(data.data)
            case .failure(let error):
                print("Terjadi error: \(error)")
                self .loadingState.accept(.failed)
            }
        }
    }
}
