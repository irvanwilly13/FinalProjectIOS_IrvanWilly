//
//  LoginViewModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 05/11/24.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class LoginViewModel: BaseViewModel {
    
    var networkManager = NetworkManager.shared

    var loginDataModel = BehaviorRelay<LoginResponse?>(value: nil)
    var disposeBag = DisposeBag()
    
    func fetchRequestData(param: LoginParam) {
        self.loadingState.accept(.loading)
        NetworkManager.shared.fetchRequest(endpoint: .login(param: param), epecting: LoginResponse.self) { result in
            switch result {
            case .success(let data):
                print("items berhasil diambil: \(data)")
                self .loadingState.accept(.finished)
                self .loginDataModel.accept(data)
            case .failure(let error):
                print("Terjadi error: \(error)")
                self .loadingState.accept(.failed)
            }
        }
    }
}
