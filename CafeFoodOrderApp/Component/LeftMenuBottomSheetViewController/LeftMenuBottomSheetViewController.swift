//
//  LeftMenuBottomSheetViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 20/10/24.
//
import FirebaseAuth
import UIKit

class LeftMenuBottomSheetViewController: UIViewController {
    
    @IBOutlet weak var coachMarkView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var chartButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configure()
        
        
        imgView.layer.cornerRadius = imgView.frame.size.width / 2
        imgView.layer.masksToBounds = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showAnimation()
        
    }
    func setup() {
        logoutButton.addTarget(self, action: #selector(actionToLogoutButton), for: .touchUpInside)
        
        profileButton.addTarget(self, action: #selector(actionToProfile), for: .touchUpInside)
        chartButton.addTarget(self, action: #selector(actionToChart), for: .touchUpInside)
        
        imgView.setCornerRadius(imgView.frame.size.width/2)
        logoutButton.setCornerRadius(16)
    }
    @objc func actionToLogoutButton() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegte = windowScene.delegate as? SceneDelegate {
            sceneDelegte.handleLogout()
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func actionToProfile() {
        let vc = ProfileViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func actionToChart() {
        let vc = ChartViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAnimation() {
        self.containerView.transform = CGAffineTransform(translationX: -self.view.frame.height, y: 0.0)
        self.coachMarkView.alpha = 0.0
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseIn]) {
            self.containerView.transform = .identity
            self.coachMarkView.alpha = 1.0
        }
    }
    
    func configure() {
        coachMarkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCoachMark)))
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        containerView.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        switch gesture.state {
        case .changed:
            if translation.x <= 0 {
                containerView.transform = CGAffineTransform(translationX: translation.x, y: 0)
            }
        case .ended:
            let dismissThreshold: CGFloat = -100
            if translation.x < dismissThreshold || velocity.x < -500 {
                UIView.animate(withDuration: 0.3) {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.containerView.transform = .identity
                }
            }
        default:
            break
        }
    }
    
    @objc func tapCoachMark() {
        UIView.animate(withDuration: 0.3) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
