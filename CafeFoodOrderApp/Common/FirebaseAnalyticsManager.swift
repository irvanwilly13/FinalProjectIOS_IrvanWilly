//
//  FirebaseAnalyticsManager.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 28/11/24.
//

import Foundation
import FirebaseAnalytics


class FirebaseAnalyticsManager {
    
    static let shared = FirebaseAnalyticsManager()
    
    private init() {}
    
    func logEvent(eventName: String, parameters: [String: Any]? = nil) {
        Analytics.logEvent(eventName, parameters: parameters)
    }
    
    func trackButtonTapRefresh(userName: String?, userEmail: String?) {
        let parameters: [String: Any] = [
            "user_name": userName ?? "unknown",
            "user_email": userEmail ?? "unknown"
        ]
        logEvent(eventName: "button_tap_refresh", parameters: parameters)
    }
    
    func trackRefreshData(userName: String?) {
        let parameters: [String: Any] = [
            "user_name": userName ?? "unknown"
        ]
        logEvent(eventName: "refresh_data", parameters: parameters)
    }
    
    func trackItemDisplayed(itemName: String) {
        logEvent(eventName: "\(itemName)_displayed")
    }
    
    func trackItemTapped(itemName: String) {
        logEvent(eventName: "\(itemName)_tapped")
    }
    
    func trackMenuOpened(userName: String?) {
        let parameters: [String: Any] = [
            "user_name": userName ?? "unknown"
        ]
        logEvent(eventName: "menu_opened", parameters: parameters)
    }
    
    func trackWhatsAppOpened(userName: String?) {
        let parameters: [String: Any] = [
            "user_name": userName ?? "unknown"
        ]
        logEvent(eventName: "whatsapp_opened", parameters: parameters)
    }
}
