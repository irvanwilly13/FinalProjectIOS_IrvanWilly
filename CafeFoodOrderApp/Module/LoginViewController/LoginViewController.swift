//
//  LoginViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 20/10/24.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth
import SkeletonView


class LoginViewController: BaseViewController {
    
    @IBOutlet weak var usernameField: CustomInputField!
    @IBOutlet weak var passwordField: CustomInputField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    var coordinator: LoginCoordinator?
    var viewModel = LoginViewModel()
    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.setCornerRadius(16)
        configure()
        setup()
        bindingData()
    }
    func setup() {
        loginButton.addTarget(self, action: #selector(actionToLoginButton), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(actionToRegister), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(actionToForgotPassword), for: .touchUpInside)
//        registerButton.setTitle(.localized(""), for: .normal)
//        loginButton.setTitle(.localized(""), for: .normal)
    }
    @objc func actionToForgotPassword() {
        let vc = ForgotPasswordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func actionToLogin() {
        let vc = MainTabBarController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func actionToRegister() {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    func configure() {
        usernameField.setup(title: "Username", placeholder: "Masukan Username")
        passwordField.setup(title: "Password", placeholder: "Masukan Password")
        passwordField.textField.isSecureTextEntry = true
        
    }
    @objc func actionToLoginButton() {
        guard let username = usernameField.textField.text,
              let password = passwordField.textField.text else {
            showAlert(message: "Tidak boleh gada isinya")
            return
        }
//        if !isValidPassword(password) {
//                showAlert(message: "Password harus minimal 8 karakter, mengandung huruf besar, huruf kecil, dan angka.")
//                return
//            }

        let param = LoginParam(username: username, password: password)
        viewModel.fetchRequestData(param: param)
        
    }
    func isValidPassword(_ password: String) -> Bool {
        // Minimal 8 karakter, 1 huruf besar, 1 huruf kecil, 1 angka
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }

    func bindingData() {
        viewModel.loginDataModel.asObservable().subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                if let token = data.data.token {
                    self.storeTokenInKeychain(token)
                    self.showAlert(message: "Berhasil login!") {
                        let vc = MainTabBarController()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
            
        }).disposed(by: disposeBag)
        
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
                    self.showAlert(message: "Login gagal. Silakan coba lagi.")
                default:
                    break
                }
            }
        }).disposed(by: disposeBag)
    }

    
    @objc func actionTologinButtonByFirebase() {
        
        guard let username = usernameField.textField.text, let password = passwordField.textField.text else {
            showAlert(message: "Tidak boleh gada isinya")
            return
        }
        
        Auth.auth().signIn(withEmail: username, password: password) { (authResult, error) in
            if let error = error {
                let errorMsg = self.handleFirebaseAuthError(error)
                self.showCustomPopup(PopUpModel(tittle: "Error", description: errorMsg, imgView: "errorX", twoButton: true))
                return
            }
            guard let user = authResult?.user else { return }
            user.getIDToken { token, error in
                if let error = error {
                    self.showAlert(message: error.localizedDescription)
                    return
                }
                
                if let token = token {
                    self.storeTokenInKeychain(token)
                    let vc = MainTabBarController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?() // Eksekusi completion jika ada
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @objc func actionToRegisterButton() {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func storeTokenInKeychain(_ token: String) {
        let tokenData = Data(token.utf8)
        KeychainHelper.shared.save(tokenData, forKey: "firebaseAuthToken")
    }
}
