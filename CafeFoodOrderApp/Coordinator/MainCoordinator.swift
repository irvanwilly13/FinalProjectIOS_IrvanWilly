//
//  MainCoordinator.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 30/10/24.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    
    func start()
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var window: UIWindow?
    
    init(navigationController: UINavigationController?, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
    }
    
    func start() {
        if let tokenData = KeychainHelper.shared.read(forKey: KeychainHelperKey.userID),
           let token = String(data: tokenData, encoding: .utf8) {
            showMainTabBar()
        } else {
            showOnBoarding()
        }
    }
    
    private func showMainTabBar() {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.modalPresentationStyle = .fullScreen
        navigationController?.setViewControllers([mainTabBarController], animated: true)
        UINavigationBar.appearance().isHidden = false
    }
    
    private func showOnBoarding() {
        guard let navigationController = navigationController else { return }
        let onboardingCoordinator = OnBoardingCoordinator(navigationController: navigationController)
        onboardingCoordinator.start()
    }
    
    private func showLogin() {
        guard let navigationController = navigationController else { return }
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.start()
    }
    
    func logout() {
        KeychainHelper.shared.delete(forKey: "firebaseAuthToken")
        
        let onboardingVC = OnBoardViewController()
        let onboardingNavigationController = UINavigationController(rootViewController: onboardingVC)
        window?.rootViewController = onboardingNavigationController
    }
}
