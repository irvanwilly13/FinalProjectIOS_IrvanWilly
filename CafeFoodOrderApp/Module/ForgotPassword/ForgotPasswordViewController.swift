//
//  ForgotPasswordViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 30/10/24.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var usernameField: CustomInputField!
    @IBOutlet weak var checkUsernameButton: UIButton!
    @IBOutlet weak var confirmPasswordField: CustomInputField!
    @IBOutlet weak var passwordField: CustomInputField!
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmPasswordField.isHidden = true
        passwordField.isHidden = true
        resetPasswordButton.isHidden = true
        confirmPasswordLabel.isHidden = true
        passwordLabel.isHidden = true
        
        setup()
        
        
    }
    func setup() {
        checkUsernameButton.addTarget(self, action: #selector(checkUsername), for: .touchUpInside)
        resetPasswordButton.addTarget(self, action: #selector(actionResetPassword), for: .touchUpInside)
        
    }
    @objc func actionResetPassword() {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    @objc func checkUsername() {
            guard let username = usernameField.text, !username.isEmpty else {
                // Tampilkan pesan jika username kosong
                print("Username tidak boleh kosong")
                return
            }
            
            // Lakukan verifikasi username di sini (misalnya dengan API call)
            verifyUsername(username) { [weak self] isVerified in
                guard let self = self else { return }
                
                if isVerified {
                    // Jika username diverifikasi, tampilkan elemen-elemen yang di-hide
                    self.confirmPasswordField.isHidden = false
                    self.passwordField.isHidden = false
                    self.resetPasswordButton.isHidden = false
                    self.confirmPasswordLabel.isHidden = false
                    self.passwordLabel.isHidden = false
                } else {
                    // Tampilkan pesan kesalahan jika username tidak valid
                    print("Username tidak valid")
                }
            }
        }
        
        // Contoh fungsi verifikasi username (Anda bisa mengubah ini dengan API call sesuai kebutuhan)
        func verifyUsername(_ username: String, completion: @escaping (Bool) -> Void) {
            // Asumsikan verifikasi berhasil jika username berisi "validUsername"
            let isVerified = username == "irvan123@gmail.com"
            completion(isVerified)
        }
    
    
}
