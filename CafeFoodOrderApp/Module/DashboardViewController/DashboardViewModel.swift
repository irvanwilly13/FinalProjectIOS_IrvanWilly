//
//  DashboardViewModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 22/10/24.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class DashboardViewModel: BaseViewModel {
    
    var networkManager = NetworkManager.shared

    var foodAppData = BehaviorRelay<FoodModel?>(value: nil)
    var disposeBag = DisposeBag()
    
    func fetchRequestData() {
        self.loadingState.accept(.loading)
        NetworkManager.shared.fetchRequest(endpoint: .getAllMenu, epecting: AllMenuModel.self) { result in
            switch result {
            case .success(let data):
                print("items berhasil diambil: \(data)")
                self .loadingState.accept(.finished)
                self .foodAppData.accept(data.data)
            case .failure(let error):
                print("Terjadi error: \(error)")
                self .loadingState.accept(.failed)
            }
            
        }
    }
}
