//
//  BaseViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 25/10/24.
//

import UIKit
import FirebaseAuth
import IQKeyboardManagerSwift


class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKeyboard()
        
        // Do any additional setup after loading the view.
    }
    func handleFirebaseAuthError(_ error: Error) -> String {
        // Casting error ke NSError untuk mengambil kode error Firebase
        let nsError = error as NSError
        let errCode = AuthErrorCode(rawValue: nsError.code)
        
        // Mengembalikan pesan error berdasarkan kode error Firebase
        switch errCode {
        case .networkError:
            return "Koneksi internet tidak stabil. Silakan coba lagi."
            
        case .userNotFound:
            return "Pengguna dengan email ini tidak ditemukan. Silakan periksa kembali."
            
        case .wrongPassword:
            return "Kata sandi yang Anda masukkan salah. Silakan coba lagi."
            
        case .invalidEmail:
            return "Format email tidak valid. Pastikan Anda menggunakan email yang benar."
            
        case .emailAlreadyInUse:
            return "Email ini sudah digunakan oleh akun lain. Gunakan email yang berbeda."
            
        case .weakPassword:
            return "Kata sandi terlalu lemah. Harap pilih kata sandi yang lebih kuat."
            
        case .userDisabled:
            return "Akun ini telah dinonaktifkan oleh administrator. Hubungi dukungan untuk informasi lebih lanjut."
            
        case .tooManyRequests:
            return "Terlalu banyak percobaan login. Silakan coba lagi nanti."
            
        default:
            return "Terjadi kesalahan yang tidak diketahui. Silakan coba lagi."
        }
    }
    open func showAlert(message: String) {
        let alert = UIAlertController(title: "Error Message", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print("tombol OK ditekan")
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    open func showCustomPopup(_ data: PopUpModel ) {
        let vc = CustomPopUpViewController()
        vc.popUpData = data
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    func configureKeyboard() {
            IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.resignOnTouchOutside = true
            IQKeyboardManager.shared.enableAutoToolbar = true
            IQKeyboardManager.shared.toolbarConfiguration.placeholderConfiguration.showPlaceholder = false
        IQKeyboardManager.shared.toolbarConfiguration.tintColor = .black
        }
}
