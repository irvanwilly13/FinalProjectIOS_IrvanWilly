//
//  OrderPageViewModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 15/11/24.
//


import RxSwift
import RxRelay
import RxCocoa

class OrderPageViewModel: BaseViewModel {
    
    var networkManager = NetworkManager.shared
    var chartAppData = BehaviorRelay<OrderDataModel?>(value: nil)
    
    func fetchRequestData(param: CreateOrderParam) {
        self.loadingState.accept(.loading)
        NetworkManager.shared.fetchRequest(endpoint: .createOrder(param: param), epecting: OrderModel.self) { result in
            switch result {
            case .success(let data):
                print("items berhasil diambil: \(data)")
                self .loadingState.accept(.finished)
                self .chartAppData.accept(data.data)
            case .failure(let error):
                print("Terjadi error: \(error)")
                self .loadingState.accept(.failed)
            }
        }
    }
}

