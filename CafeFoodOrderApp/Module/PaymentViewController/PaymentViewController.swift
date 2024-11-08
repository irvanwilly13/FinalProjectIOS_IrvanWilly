//
//  PaymentViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 26/10/24.
//

import UIKit
import SkeletonView

class PaymentViewController: UIViewController, PaymentMethodDelegate {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var paymentMethodeButton: UIButton!
    
    @IBOutlet weak var toolBarView: ToolBarView!
    @IBOutlet weak var paymentLabel: UILabel!
    
    var totalAmount: String? // Property untuk menyimpan nilai total

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        updateTotalLabel()

    }
    func setup() {
        paymentButton.addTarget(self, action: #selector(actionToPayment), for: .touchUpInside)
        paymentMethodeButton.addTarget(self, action: #selector(openPaymentMethod), for: .touchUpInside)

        toolBarView.setup(title: "Payment")



    }
    @objc func actionToPayment() {
        let vc = ConfirmPaymentViewController()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    func updateTotalLabel() {
            totalLabel.text = totalAmount // Atur totalLabel menggunakan nilai totalAmount
        }
    @objc func openPaymentMethod() {
            let vc = BottomSheetViewController()
            vc.delegate = self // Tetapkan delegate ke PaymentViewController
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        }
    func didSelectPaymentMethod(_ method: String) {
            paymentLabel.text = "Metode Pembayaran: \(method)" // Update label dengan metode yang dipilih
        }
    


}
