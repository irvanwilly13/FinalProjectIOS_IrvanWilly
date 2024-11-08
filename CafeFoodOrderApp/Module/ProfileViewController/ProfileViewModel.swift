//
//  ProfileViewModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 25/10/24.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class ProfileViewModel: BaseViewModel {
    
    var networkManager = NetworkManager.shared

    var profileDataModel = BehaviorRelay<DataProfileModel?>(value: nil)
    var disposeBag = DisposeBag()
    
    func fetchRequestData() {
        self.loadingState.accept(.loading)
        NetworkManager.shared.fetchRequest(endpoint: .getAllProfile, epecting: DataProfileModel.self) { result in
            switch result {
            case .success(let data):
                print("items berhasil diambil: \(data)")
                self .loadingState.accept(.finished)
                self .profileDataModel.accept(data)
            case .failure(let error):
                print("Terjadi error: \(error)")
                self .loadingState.accept(.failed)
            }
            
        }
    }
}
