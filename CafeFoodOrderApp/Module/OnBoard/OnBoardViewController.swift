//
//  OnBoardViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 20/10/24.
//

import UIKit
import RxCocoa
import RxSwift

class OnBoardViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    var coordinator: OnBoardingCoordinator?

       override func viewDidLoad() {
           super.viewDidLoad()
           setupBindings()
           setupLocalization()
           loginButton.setCornerRadius(16)
           registerButton.setCornerRadius(16)
       }

       func setupBindings() {
           loginButton.rx.tap
               .subscribe(onNext: { [weak self] in
                   guard let self = self else { return }
                   self.moveToLogin()
                   
//                   let vc = LoginViewController()
//                   self.navigationController?.pushViewController(vc, animated: true)
               })
               .disposed(by: disposeBag)
           
           registerButton.rx.tap
               .subscribe(onNext: { [weak self] in
                   guard let self = self else { return }
                   self.moveToRegister()
//                   let vc = RegisterViewController()
//                   self.navigationController?.pushViewController(vc, animated: true)
               })
               .disposed(by: disposeBag)
       }
    func setupLocalization() {
        registerButton.setTitle(.localized("register_button"), for: .normal)
        loginButton.setTitle(.localized("login_button"), for: .normal)
        }

    
    func moveToLogin() {
        coordinator?.showLogin()
//        let loginCoordinator = LoginCoordinator(navigationController: navigationController ?? UINavigationController())
//        loginCoordinator.start()
    }
    func moveToRegister() {
        coordinator?.showRegister()
    }
   }
