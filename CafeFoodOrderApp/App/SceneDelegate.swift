//
//  SceneDelegate.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 20/10/24.
//

import UIKit
import MidtransKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: MainCoordinator?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        setupMidtransConfig()
        
        let navController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navController, window: window)
        coordinator?.start()
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
//        if let tokenData = KeychainHelper.shared.read(forKey: "firebaseAuthToken"),
//           let token = String(data: tokenData, encoding: .utf8) {
//            let tabBar = MainTabBarController()
//            tabBar.modalPresentationStyle = .fullScreen
//            let navigation = UINavigationController(rootViewController: tabBar)
//            window.rootViewController = navigation
//            window.makeKeyAndVisible()
//            self.window = window
//            UINavigationBar.appearance().isHidden = false
//
//        } else {
//            // Jika user belum login, buka onboarding page
//            createOnboardingVC(window: window)
//        }
//        
//        window.makeKeyAndVisible()
//        self.window = window
    }
    private func setupMidtransConfig() {
          MidtransConfig.shared().setClientKey("SB-Mid-client-DMzFzhAUqMIxUcTC", environment: .sandbox, merchantServerURL:"https://merchant-url-sandbox.com"
          )
          //enable logger for debugging purpose
          MidtransNetworkLogger.shared()?.startLogging()
        }
  
    
    func createOnboardingVC(window: UIWindow) {
        
        let vc =  OnBoardViewController()
        let navigation = UINavigationController(rootViewController: vc)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        self.window = window
        
    }
    
    func handleLogout() {
        KeychainHelper.shared.delete(forKey: KeychainHelperKey.userID)
        
//        let vc = OnBoardViewController()
//        let navigation = UINavigationController(rootViewController: vc)
//        window?.rootViewController = navigation
        
        
        let navController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navController, window: window)
        coordinator?.start()
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

