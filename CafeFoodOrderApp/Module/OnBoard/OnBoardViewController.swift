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
    
    @IBOutlet weak var greetingBottomLabel: UILabel!
    @IBOutlet weak var greetingTopLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    var coordinator: OnBoardingCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
            })
            .disposed(by: disposeBag)
        
        registerButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.moveToRegister()
            })
            .disposed(by: disposeBag)
    }
    
    func setupLocalization() {
        registerButton.setTitle(.localized("register_button"), for: .normal)
        loginButton.setTitle(.localized("login_button"), for: .normal)
        
        welcomeLabel.text = .localized("welcome_message")
        greetingTopLabel.text = .localized("greeting1")
        greetingBottomLabel.text = .localized("greeting2")

    }
    func setup() {
        welcomeLabel.font = .foodBlackNorth(30)
        greetingTopLabel.font = .foodOpenSansBold(24)
        greetingBottomLabel.font = .foodOpenSansBold(24)
    }
    
    func moveToLogin() {
        coordinator?.showLogin()
    }
    
    func moveToRegister() {
        coordinator?.showRegister()
    }
}
