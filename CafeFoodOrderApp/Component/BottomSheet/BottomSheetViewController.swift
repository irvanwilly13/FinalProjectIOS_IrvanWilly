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
        super.viewDidLoad()
        
        // Menambahkan target untuk setiap tombol pembayaran
        bcaButton.addTarget(self, action: #selector(selectBCAPayment), for: .touchUpInside)
        mandiriButton.addTarget(self, action: #selector(selectMandiriPayment), for: .touchUpInside)
        gopayButton.addTarget(self, action: #selector(selectGopayPayment), for: .touchUpInside)
        
        // Menambahkan target untuk tombol Apply
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
    
    // Fungsi untuk memilih pembayaran Mandiri
    @objc func selectMandiriPayment() {
        selectedPaymentMethod = "Mandiri"
        updateButtonSelection()
    }
    
    // Fungsi untuk memilih pembayaran Gopay
    @objc func selectGopayPayment() {
        selectedPaymentMethod = "Gopay"
        updateButtonSelection()
    }
    
    // Fungsi untuk memperbarui tampilan tombol yang dipilih
    func updateButtonSelection() {
        bcaButton.setTitle(selectedPaymentMethod == "BCA" ? "✅ BCA" : "⬜ BCA", for: .normal)
        mandiriButton.setTitle(selectedPaymentMethod == "Mandiri" ? "✅ Mandiri" : "⬜ Mandiri", for: .normal)
        gopayButton.setTitle(selectedPaymentMethod == "Gopay" ? "✅ Gopay" : "⬜ Gopay", for: .normal)
        
        bcaButton.backgroundColor = selectedPaymentMethod == "BCA" ? .lightGray : .clear
        mandiriButton.backgroundColor = selectedPaymentMethod == "Mandiri" ? .lightGray : .clear
        gopayButton.backgroundColor = selectedPaymentMethod == "Gopay" ? .lightGray : .clear
    }
    
    // Fungsi untuk menampilkan pilihan yang dipilih saat tombol Apply ditekan
    @objc func applyPaymentMethod() {
        guard let paymentMethod = selectedPaymentMethod else {
            // Jika tidak ada pilihan pembayaran yang dipilih, tampilkan pesan
            showAlert(message: "Pilih metode pembayaran terlebih dahulu.")
            return
        }
        delegate?.didSelectPaymentMethod(paymentMethod) // Kirim data ke delegate
        dismiss(animated: true, completion: nil)
        // Tampilkan pilihan pembayaran yang telah dipilih
        print("Metode pembayaran yang dipilih: \(paymentMethod)")
        showAlert(message: "Anda telah memilih pembayaran dengan \(paymentMethod).")
        
    }
    
    // Fungsi untuk menampilkan alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Metode Pembayaran", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
