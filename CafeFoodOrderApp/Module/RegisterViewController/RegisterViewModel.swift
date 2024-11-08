//
//  RegisterViewModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 05/11/24.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class RegisterViewModel: BaseViewModel {
    
    var networkManager = NetworkManager.shared

    var RegisterDataModel = BehaviorRelay<RegisterResponse?>(value: nil)
    var disposeBag = DisposeBag()
    
    func fetchRequestData(param: RegistParam) {
        self.loadingState.accept(.loading)
        NetworkManager.shared.fetchRequest(endpoint: .register(registerParam: param), epecting: RegisterResponse.self) { result in
            switch result {
            case .success(let data):
                print("items berhasil diambil: \(data)")
                self .loadingState.accept(.finished)
                self .RegisterDataModel.accept(data)
            case .failure(let error):
                print("Terjadi error: \(error)")
                self .loadingState.accept(.failed)
            }
            
        }
    }
}
