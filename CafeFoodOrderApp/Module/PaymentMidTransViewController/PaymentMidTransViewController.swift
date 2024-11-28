//
//  PaymentMidTransViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 07/11/24.
//

import UIKit
import MidtransKit

class PaymentMidTransViewController: UIViewController {
    
    var token: String?
    private var paymentViewController: MidtransUIPaymentViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTransactionToken()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePaymentStatusUpdated(_:)),
            name: Notification.Name("PaymentStatusUpdated"),
            object: nil
        )
    }
    
    private func requestTransactionToken() {
        MidtransMerchantClient.shared().requestTransacation(
            withCurrentToken: token ?? ""
        ) { [weak self] (response, error) in
            guard let self = self else { return }
            
            if let response = response {
                DispatchQueue.main.async {
                    self.paymentViewController = MidtransUIPaymentViewController(token: response)
                    
                    if let paymentVC = self.paymentViewController {
                        paymentVC.paymentDelegate = self
                        
                        self.present(paymentVC, animated: true) {
                            print("Payment view controller presented successfully")
                        }
                    } else {
                        print("Failed to initialize payment view controller")
                    }
                }
            } else if let error = error {
                print("Transaction token request failed: \(error.localizedDescription)")
            }
        }
    }
}

extension PaymentMidTransViewController: MidtransUIPaymentViewControllerDelegate {
    
    func paymentViewController(_ viewController: MidtransUIPaymentViewController!, paymentPending result: MidtransTransactionResult!) {
        print("Payment pending - Order ID: \(result.orderId ?? "unknown")")
        dismiss(animated: true) {
            self.handlePaymentStatus(status: "pending", result: result)
        }
    }
    
    func paymentViewController(_ viewController: MidtransUIPaymentViewController!, paymentDeny result: MidtransTransactionResult!) {
        print("Payment denied - Order ID: \(result.orderId ?? "unknown")")
        dismiss(animated: true) {
            self.handlePaymentStatus(status: "denied", result: result)
        }
    }
    
    func paymentViewController(_ viewController: MidtransUIPaymentViewController!, paymentSuccess result: MidtransTransactionResult!) {
        print("Payment success - Order ID: \(result.orderId ?? "unknown")")
        
        dismiss(animated: true) {
            self.handlePaymentStatus(status: "success", result: result)
        }
    }
    
    func paymentViewController(_ viewController: MidtransUIPaymentViewController!, paymentFailed error: Error!) {
        print("Payment failed: \(error.localizedDescription)")
        dismiss(animated: true) {
            self.handlePaymentError(error: error)
        }
    }
    
    func paymentViewController_paymentCanceled(_ viewController: MidtransUIPaymentViewController!) {
        print("Payment cancelled by user")
        dismiss(animated: true) {
            self.handlePaymentStatus(status: "cancelled", result: nil)
        }
    }
    
    private func handlePaymentStatus(status: String, result: MidtransTransactionResult?) {
        let orderId = result?.orderId ?? "unknown"
        let transactionStatus = result?.transactionStatus ?? "unknown"
        
        print("Payment Status: \(status)")
        print("Order ID: \(orderId)")
        print("Transaction Status: \(transactionStatus)")
        
        NotificationCenter.default.post(
            name: Notification.Name("PaymentStatusUpdated"),
            object: nil,
            userInfo: [
                "status": status,
                "orderId": orderId,
                "transactionStatus": transactionStatus
            ])
    }
    
    @objc private func handlePaymentStatusUpdated(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let status = userInfo["status"] as? String,
              let orderId = userInfo["orderId"] as? String,
              let transactionStatus = userInfo["transactionStatus"] as? String else {
            print("Data not complete")
            return
        }
        
        print("Payment status: \(status)")
        print("Order ID: \(orderId)")
        print("Transaction Status: \(transactionStatus)")
        
        if transactionStatus == "capture" || transactionStatus == "settlement" {
            print("Pembayaran berhasil")
            self.navigateToConfirmPaymentViewController(orderID: orderId)
        } else if transactionStatus == "pending" {
            print("Menunggu pembayaran")
            self.tabBarController?.selectedIndex = 0
            
            if let navigationController = self.tabBarController?.viewControllers?[1] as? UINavigationController {
                navigationController.popToRootViewController(animated: false)
            }
        } else {
            print("Transaksi gagal: \(transactionStatus)")
        }
    }
    
    private func handlePaymentError(error: Error) {
        print("Payment Error: \(error.localizedDescription)")
        
        NotificationCenter.default.post(
            name: Notification.Name("PaymentError"),
            object: nil,
            userInfo: ["error": error]
        )
    }
    private func navigateToConfirmPaymentViewController(orderID: String) {
        let vc = HistoryOrderDetailViewController()
        vc.orderID = orderID
        vc.isFrom = "MidTrans"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
