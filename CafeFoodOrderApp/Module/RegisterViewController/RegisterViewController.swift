//
//  RegisterViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 20/10/24.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth
import SkeletonView

class RegisterViewController: BaseViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var phoneNumberField: CustomInputField!
    @IBOutlet weak var fullnameField: CustomInputField!
    @IBOutlet weak var emailField: CustomInputField!
    @IBOutlet weak var usernameField: CustomInputField!
    @IBOutlet weak var passwordField: CustomInputField!
    @IBOutlet weak var confirmPasswordField: CustomInputField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var coordinator: RegisterCoordinator?
    var viewModel = RegisterViewModel()
    var disposeBag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberField.textField.delegate = self

        registerButton.setCornerRadius(16)
        setup()
        configure()
        bindingData()
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == phoneNumberField.textField {
                let allowedCharacters = CharacterSet.decimalDigits
                let characterSet = CharacterSet(charactersIn: string)
                return allowedCharacters.isSuperset(of: characterSet)
            }
            return true
        }
    func setup() {
        registerButton.addTarget(self, action: #selector(actionToCreateButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(actionToLogin), for: .touchUpInside)
        
    }
    
    @objc func actionToRegister() {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func actionToLogin() {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func configure() {
        emailField.setup(title: "Email", placeholder: "Masukan Email")
        fullnameField.setup(title: "Full Name", placeholder: "Masukan Full Name")
        phoneNumberField.setup(title: "Phone Number", placeholder: "Masukan Phone Number")
        usernameField.setup(title: "Username", placeholder: "Masukan Username")
        passwordField.setup(title: "Password", placeholder: "Masukan Password")
        confirmPasswordField.setup(title: "Confirm Password", placeholder: "Masukan Password")
        passwordField.textField.isSecureTextEntry = true
        confirmPasswordField.textField.isSecureTextEntry = true
    }
    
    @objc func actionToCreateButton() {
        guard let username = usernameField.textField.text,
              let password = passwordField.textField.text,
              let confirmPassword = confirmPasswordField.textField.text,
              let email = emailField.textField.text,
              let fullname = fullnameField.textField.text,
              let phoneNumber = phoneNumberField.textField.text
        else {
            showAlert(message: "Tidak boleh kosong")
            return
        }
        if username.isEmpty || password.isEmpty || confirmPassword.isEmpty || email.isEmpty || fullname.isEmpty || phoneNumber.isEmpty {
                showAlert(message: "Semua field harus diisi.")
                return
            }
        
        if password != confirmPassword {
            self.showAlert(message: "Password Doesn't Match")
            return
        }
        if !isValidPhoneNumber(phoneNumber) {
                showAlert(message: "Nomor telepon tidak valid. Harus berisi hanya angka dan minimal 10 digit.")
                return
            }
        if !isValidPassword(password) {
                showAlert(message: "Password harus minimal 8 karakter, mengandung huruf besar, huruf kecil, dan angka.")
                return
            }
        if !isValidEmail(email) {
                showAlert(message: "Format email tidak valid.")
                return
            }
        let param = RegistParam(username: username, password: password, email: email, fullname: fullname, phoneNumber: phoneNumber)
        viewModel.fetchRequestData(param: param)
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        // Minimal 8 karakter, 1 huruf besar, 1 huruf kecil, 1 angka
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }

    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        // Hanya angka, minimal 10 digit
        let phoneNumberRegEx = "^[0-9]{10,}$"
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegEx)
        return phonePred.evaluate(with: phoneNumber)
    }

    
    func bindingData() {
        // Observing Register Data Model
        viewModel.RegisterDataModel.asObservable().subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            if let data = data {
                DispatchQueue.main.async {
                    // Menampilkan pesan sukses jika data registrasi berhasil
                    self.showAlertSuccess(title: "Registration Success", message: "Account created successfully.") {
                        let loginVC = LoginViewController()
                        self.navigationController?.pushViewController(loginVC, animated: true)
                    }
                }
                
            }
        }).disposed(by: disposeBag)
        
        // Observing Loading State
        viewModel.loadingState.asObservable().subscribe(onNext: { [weak self] loading in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch loading {
                case .loading:
                    self.view.showAnimatedSkeleton()
                case .finished:
                    self.view.hideSkeleton()
                case .failed:
                    self.view.hideSkeleton()
                    self.showAlert(message: "Failed to register. Please try again.")
                default:
                    break
                }
            }
        }).disposed(by: disposeBag)
        
    }
    
    func logicByFirebase(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                let errorMsg = self.handleFirebaseAuthError(error)
                self.showAlert(message: errorMsg)
                return
            }
            self.showAlertSuccess(title: "Success", message: "Have successfully created an account") {
                let vc = LoginViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }


    func showAlertSuccess(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Memanggil closure jika diberikan
            completion?()
        }
        
        alertController.addAction(okAction)
        
        // Menampilkan alert
        self.present(alertController, animated: true, completion: nil)
    }

}







