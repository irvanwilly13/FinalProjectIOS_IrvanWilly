//
//  OnBoardingCoordinator.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 30/10/24.
//

import Foundation
import UIKit

class OnBoardingCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }
        let onboardVC = OnBoardViewController()
        onboardVC.coordinator = self
        navigationController.pushViewController(onboardVC, animated: true)
    }
    
    func showLogin() {
        guard let navigationController = navigationController else {
            return
        }
        
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.start()
    }
    
    func showRegister() {
        guard let navigationController = navigationController else {
            return
        }
        
        let registerCoordinator = RegisterCoordinator(navigationController: navigationController)
        registerCoordinator.start()
    }
}
