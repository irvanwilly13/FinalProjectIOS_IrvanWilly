//
//  BottomSheetViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 26/10/24.
//

import UIKit

protocol PaymentMethodDelegate: AnyObject {
    func didSelectPaymentMethod(_ method: String)
}

class BottomSheetViewController: UIViewController {
    
    @IBOutlet weak var coachMarkView: UIView!
    @IBOutlet weak var bcaButton: UIButton!
    @IBOutlet weak var mandiriButton: UIButton!
    @IBOutlet weak var gopayButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    
    var selectedPaymentMethod: String?
    weak var delegate: PaymentMethodDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bcaButton.addTarget(self, action: #selector(selectBCAPayment), for: .touchUpInside)
        mandiriButton.addTarget(self, action: #selector(selectMandiriPayment), for: .touchUpInside)
        gopayButton.addTarget(self, action: #selector(selectGopayPayment), for: .touchUpInside)
        
        applyButton.addTarget(self, action: #selector(applyPaymentMethod), for: .touchUpInside)
        coachMarkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCoachMark)))
        
    }
    @objc func tapCoachMark() {
        UIView.animate(withDuration: 0.3) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    @objc func selectBCAPayment() {
        selectedPaymentMethod = "BCA"
        updateButtonSelection()
    }
    
    @objc func selectMandiriPayment() {
        selectedPaymentMethod = "Mandiri"
        updateButtonSelection()
    }
    
    @objc func selectGopayPayment() {
        selectedPaymentMethod = "Gopay"
        updateButtonSelection()
    }
    
    func updateButtonSelection() {
        bcaButton.setTitle(selectedPaymentMethod == "BCA" ? "✅" : "⬜", for: .normal)
        mandiriButton.setTitle(selectedPaymentMethod == "Mandiri" ? "✅" : "⬜", for: .normal)
        gopayButton.setTitle(selectedPaymentMethod == "Gopay" ? "✅" : "⬜", for: .normal)
        
        bcaButton.backgroundColor = selectedPaymentMethod == "BCA" ? .clear : .clear
        mandiriButton.backgroundColor = selectedPaymentMethod == "Mandiri" ? .clear : .clear
        gopayButton.backgroundColor = selectedPaymentMethod == "Gopay" ? .clear : .clear
    }
    
    @objc func applyPaymentMethod() {
        guard let paymentMethod = selectedPaymentMethod else {
            showAlert(message: "Pilih metode pembayaran terlebih dahulu.")
            return
        }
        delegate?.didSelectPaymentMethod(paymentMethod)
        dismiss(animated: true, completion: nil)
        // Tampilkan pilihan pembayaran yang telah dipilih
        print("Metode pembayaran yang dipilih: \(paymentMethod)")
        showAlert(message: "Anda telah memilih pembayaran dengan \(paymentMethod).")
        
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Metode Pembayaran", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
