//
//  RegisterCoordinator.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 30/10/24.
//

import Foundation
import UIKit

class RegisterCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func start() {
        let registerVC = RegisterViewController()
        registerVC.coordinator = self
        navigationController?.pushViewController(registerVC, animated: true)
    }
}
