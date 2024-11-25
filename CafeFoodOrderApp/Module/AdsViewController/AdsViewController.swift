//
//  AdsViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 20/11/24.
//

import UIKit
import WebKit

class AdsViewController: BaseViewController {

    @IBOutlet weak var toolBarView: ToolBarView!
    @IBOutlet weak var webView: WKWebView!
    
    var url: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        toolBarView.setup(title: "URL Information")
        hideNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let urlString = url, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        } else {
            print("Invalid or nil URL")
        }
    }
    
    func hideNavigationBar() {
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.hidesBottomBarWhenPushed = false
    }

    
}

extension AdsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
}
