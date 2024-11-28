//
//  ChartViewModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 11/11/24.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class ChartViewModel: BaseViewModel {
    
    var networkManager = NetworkManager.shared
    var chartAppData = BehaviorRelay<OrderDataModel?>(value: nil)
    
}
