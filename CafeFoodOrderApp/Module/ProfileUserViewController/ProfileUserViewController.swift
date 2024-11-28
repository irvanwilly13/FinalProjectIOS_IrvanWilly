//
//  ProfileUserViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 06/11/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import SkeletonView

class ProfileUserViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerCardView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameCardLabel: UILabel!
    
    @IBOutlet weak var containerImgView: UIView!
    @IBOutlet weak var qrCodeButton: UIButton!
    @IBOutlet weak var voucherButton: UIButton!
    
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    @IBOutlet weak var termsServicesButton: UIButton!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var helpCenterButton: UIButton!
    @IBOutlet weak var addressButton: UIButton!
    
    var viewModel = ProfileUserViewModel()
    let disposeBag = DisposeBag()
    var profileData: [DataProfileUser] = []
    
    lazy var profileSkeletonView = ProfileUserSkeletonView(frame: scrollView.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        applyGradientBackground()
        bindingData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    
    func shouldShowErrorView(status: Bool) {
        switch status {
        case true:
            if !view.subviews.contains(profileSkeletonView) {
                view.addSubview(profileSkeletonView)
                scrollView.isHidden = true
            } else {
                profileSkeletonView.isHidden = false
                scrollView.isHidden = true
            }
        case false:
            if view.subviews.contains(profileSkeletonView) {
                profileSkeletonView.isHidden = true
                scrollView.isHidden = false
            }
        }
    }
    
    func configure(data: DataProfileUser) {
        DispatchQueue.main.async {
            // self.imgView.image = UIImage(named: data.prImageURL)
            self.nameLabel.text = data.user.usFullname
            self.nameCardLabel.text = data.user.usFullname
        }
    }
    
    func bindingData() {
        viewModel.loadingState.asObservable().subscribe(onNext: { [ weak self ] loading in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch loading {
                case .loading:
                    print("loading")
                    self.shouldShowErrorView(status: true)
                case .failed:
                    print("failed")
                    self.shouldShowErrorView(status: false)
                case .finished:
                    self.shouldShowErrorView(status: false)
                    print("finished")
                default:
                    break
                }
            }
        }).disposed(by: disposeBag)
        viewModel.profileDataModel.asObservable().subscribe(onNext: { [ weak self ] item in
            DispatchQueue.main.async {
                guard let self = self else { return }
                guard let profileData = item?.data else { return }
                self.configure(data: profileData)
            }
        }).disposed(by: disposeBag)
        viewModel.fetchRequestData()
    }
    //    func showSkeleton(show: Bool) {
    //        if show {
    //            containerCardView.showAnimatedGradientSkeleton()
    //            nameLabel.showAnimatedGradientSkeleton()
    //            imgView.showAnimatedGradientSkeleton()
    //            nameCardLabel.showAnimatedGradientSkeleton()
    //            containerImgView.showAnimatedGradientSkeleton()
    //            qrCodeButton.showAnimatedGradientSkeleton()
    //            voucherButton.showAnimatedGradientSkeleton()
    //            settingsButton.showAnimatedGradientSkeleton()
    //            privacyPolicyButton.showAnimatedGradientSkeleton()
    //            
    //        }
    //    }
    
    func hideNavigationBar() {
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isTranslucent = false
        //self.hidesBottomBarWhenPushed = false
    }
    
    func setup() {
        settingsButton.addTarget(self, action: #selector(actionToSettings), for: .touchUpInside)
        privacyPolicyButton.addTarget(self, action: #selector(actionToPolicy), for: .touchUpInside)
        termsServicesButton.addTarget(self, action: #selector(actionToTermsService), for: .touchUpInside)
        helpCenterButton.addTarget(self, action: #selector(actionToHelpCenter), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionToSettings))
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(tapGesture)
    }
    @objc func actionToPolicy() {
        let vc = PrivacyPolicyViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func actionToTermsService() {
        let vc = TermOfServicesViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func actionToHelpCenter() {
        let vc = HelpCenterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func actionToAddress() {
        let vc = PickAddressViewController()
        vc.isFromProfile = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func actionToSettings() {
        let vc = ChangeInformationViewController()
        vc.profileData = self.viewModel.profileDataModel.value?.data
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func applyGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = containerCardView.bounds
        gradientLayer.colors = [
            UIColor.black.cgColor,
            UIColor.darkGray.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.cornerRadius = 12
        
        containerCardView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerCardView.layer.sublayers?.first?.frame = containerCardView.bounds
        containerImgView.layer.cornerRadius = containerImgView.frame.width / 2
        containerImgView.layer.masksToBounds = true
    }
}
