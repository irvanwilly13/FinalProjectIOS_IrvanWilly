//
//  BottomSheetAddAddressViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 19/11/24.
//

import UIKit

protocol BottomSheetAddAddressDelegate: AnyObject {
    func didAddNewAddress()
}

class BottomSheetAddAddressViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var coachMarkView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var alamatField: CustomInputField!
    @IBOutlet weak var kabupatenField: CustomInputField!
    @IBOutlet weak var profinsiField: CustomInputField!
    @IBOutlet weak var kodePosField: CustomInputField!
    
    weak var delegate: BottomSheetAddAddressDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configure()
    }
    
    func setup() {
//        modalPresentationStyle = .overFullScreen
//        modalTransitionStyle = .crossDissolve
//        view.backgroundColor = .clear
        alamatField.setup(title: "Alamat:", placeholder: "")
        kabupatenField.setup(title: "Kabupaten:", placeholder: "")
        profinsiField.setup(title: "Profinsi:", placeholder: "")
        kodePosField.setup(title: "Kode Pos:", placeholder: "")
        containerView.makeCornerRadius(16, maskedCorner: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        guard
            let alamat = alamatField.text, !alamat.isEmpty,
            let kabupaten = kabupatenField.text, !kabupaten.isEmpty,
            let profinsi = profinsiField.text, !profinsi.isEmpty,
            let kodePos = kodePosField.text, !kodePos.isEmpty
        else {
            print("All fields are required")
            return
        }
        
        let result = CoreDataManager.shared.addAddress(
            alamat: alamat,
            kabupaten: kabupaten,
            profinsi: profinsi,
            kodePos: kodePos
        )
        
        switch result {
        case .added:
            print("Address added successfully.")
            
            // Panggil delegasi untuk memberi tahu bahwa data telah ditambahkan
            delegate?.didAddNewAddress()
            dismiss(animated: true, completion: nil)

           // navigationController?.popViewController(animated: true)
        case .failed:
            print("Failed to add address.")
        default:
            break
        }
    }
    func configure() {
        coachMarkView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        coachMarkView.isOpaque = false // Pastikan transparansi diterapkan
        coachMarkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCoachMark)))
    }
    
    @objc func tapCoachMark() {
        UIView.animate(withDuration: 0.3) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            coachMarkView.frame = self.view.bounds // Memastikan coachMarkView menutupi seluruh layar
        }
}
