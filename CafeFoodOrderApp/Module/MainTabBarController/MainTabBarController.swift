//
//  MainTabBarController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 21/10/24.
//

import Foundation
import UIKit

enum MainTabBarType: Int, CaseIterable {
    case dashboard
    case chart
    case middle
    case history
    case profile
}

class MainTabBarController: UITabBarController {
    
    private var cartObserver: NSObjectProtocol?
    
    let btnMiddle : UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        btn.setTitle("", for: .normal)
        btn.backgroundColor = UIColor.orange
        btn.layer.cornerRadius = 30
        btn.layer.shadowColor = UIColor(named: "#F9881F")?.cgColor
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        btn.tintColor = UIColor.white
        return btn
    }()
    
    let dashboard = UINavigationController(rootViewController: DashboardViewController())
    let chart = UINavigationController(rootViewController: ChartViewController())
    let middle = UINavigationController(rootViewController: MapKitViewController())
    let history = UINavigationController(rootViewController: HistoryOrderViewController())
    let profile = UINavigationController(rootViewController: ProfileUserViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUITabBarItems()
        configureTabBar()
        setupCartObserver()
        updateCartBadge()
    }
    
    deinit {
        if let observer = cartObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    private func setupCartObserver() {
        // Create a notification name for cart updates
        let notificationName = Notification.Name("ChartUpdate")
        
        cartObserver = NotificationCenter.default.addObserver(
            forName: notificationName,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.updateCartBadge()
        }
    }
    
    private func updateCartBadge() {
        let cartItems = CartService.shared.getCartItem()
        let totalItems = cartItems.reduce(0) { $0 + $1.quantity }
        
        if totalItems > 0 {
            chart.tabBarItem.badgeValue = "\(totalItems)"
            chart.tabBarItem.badgeColor = .red
        } else {
            chart.tabBarItem.badgeValue = nil
        }
    }
    
    override func loadView() {
        super.loadView()
        self.tabBar.addSubview(btnMiddle)
        self.tabBar.backgroundColor = UIColor.white
        self.tabBar.tintColor = UIColor(named: "#F9881F")
    }
    func configureTabBar() {
        self.setViewControllers([dashboard,chart,middle,history,profile], animated: true)
        btnMiddle.frame = CGRect(x: Int(self.tabBar.bounds.width)/2 - 30, y: -20, width: 60, height: 60)
        
    }
    
    func configureUITabBarItems() {
        dashboard.tabBarItem = UITabBarItem(title: "Home", image: SFSymbols.dashboardSymbol, tag: 0)
        chart.tabBarItem = UITabBarItem(title: "Chart", image: SFSymbols.chartSymbol, tag: 1)
        history.tabBarItem = UITabBarItem(title: "history", image: SFSymbols.historySymbol, tag: 2)
        profile.tabBarItem = UITabBarItem(title: "Profil", image: SFSymbols.profilSymbol, tag: 3)
        
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
        UITabBar.appearance().tintColor = UIColor.magenta
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
        updateCartBadge()
    }
    
    func hideNavigationBar() {
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.hidesBottomBarWhenPushed = false
    }
    
}

extension MainTabBarController {
    func switchToTab(type: MainTabBarType) {
        self.selectedIndex = type.rawValue
        
        switch  type {
        case .dashboard:
            if let dashboardVC = self.viewControllers?[0] as? DashboardViewController {
                self.selectedViewController = dashboardVC
            }
        case .chart:
            if let VC = self.viewControllers?[1] as? ChartViewController {
                self.selectedViewController = VC
            }
        case .middle:
            if let VC = self.viewControllers?[2] as? MapKitViewController {
                self.selectedViewController = VC
            }
        case .history:
            if let VC = self.viewControllers?[3] as? HistoryOrderViewController {
                self.selectedViewController = VC
            }
        case .profile:
            if let VC = self.viewControllers?[4] as? ProfileViewController {
                self.selectedViewController = VC
            }
        }
    }
    
    func switchTo(type: MainTabBarType) {
        self.selectedIndex = type.rawValue
        
        switch  type {
        case .dashboard:
            if let navigation = self.viewControllers?[0] as? UINavigationController {
                navigation.popToRootViewController(animated: false)
            }
        case .chart:
            if let navigation = self.viewControllers?[1] as? UINavigationController {
                navigation.popToRootViewController(animated: false)
            }
        case .middle:
            if let navigation = self.viewControllers?[2] as? UINavigationController {
                navigation.popToRootViewController(animated: false)
            }
        case .history:
            if let navigation = self.viewControllers?[3] as? UINavigationController {
                navigation.popToRootViewController(animated: false)
            }
        case .profile:
            if let navigation = self.viewControllers?[4] as? UINavigationController {
                navigation.popToRootViewController(animated: false)
            }
        }
    }
}

