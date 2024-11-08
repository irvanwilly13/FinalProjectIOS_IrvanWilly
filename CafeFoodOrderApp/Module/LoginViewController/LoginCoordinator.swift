//
//  LoginCoordinator.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 30/10/24.
//

import Foundation
import UIKit

class LoginCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginVC = LoginViewController()
        loginVC.coordinator = self
        navigationController?.pushViewController(loginVC, animated: true)
    }
}
