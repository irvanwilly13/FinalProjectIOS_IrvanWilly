//
//  ChangeInformationViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 04/11/24.
//

import UIKit

class ChangeInformationViewController: UIViewController {
    
    @IBOutlet weak var toolBarView: ToolBarView!
    
    @IBOutlet weak var nameField: CustomInputField!
    @IBOutlet weak var emailField: CustomInputField!
    @IBOutlet weak var genderField: CustomInputField!
    @IBOutlet weak var birthdayField: CustomInputField!
    @IBOutlet weak var phoneNumberField: CustomInputField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setup()
        loadSavedData()
        
    }
    
    func configure() {
        nameField.setup(title: "Name", placeholder: "")
        emailField.setup(title: "Email", placeholder: "")
        genderField.setup(title: "Gender", placeholder: "")
        birthdayField.setup(title: "Birthday", placeholder: "")
        phoneNumberField.setup(title: "Phone Number", placeholder: "")
    }
    
    func setup() {
        saveButton.addTarget(self, action: #selector(actionToSaveButton), for: .touchUpInside)
    }
    
    // Fungsi untuk menyimpan data terakhir yang diisi di textField
    @objc func actionToSaveButton() {
        // Menyimpan data ke UserDefaults
        UserDefaults.standard.set(nameField.text, forKey: "name")
        UserDefaults.standard.set(emailField.text, forKey: "email")
        UserDefaults.standard.set(genderField.text, forKey: "gender")
        UserDefaults.standard.set(birthdayField.text, forKey: "birthday")
        UserDefaults.standard.set(phoneNumberField.text, forKey: "phoneNumber")
        
        // Menampilkan alert bahwa data berhasil disimpan
        let alert = UIAlertController(title: "Success", message: "Information saved successfully!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // Fungsi untuk memuat data yang tersimpan dan menampilkan di textField
    func loadSavedData() {
        nameField.text = UserDefaults.standard.string(forKey: "name") ?? "Irvan Willy"
        emailField.text = UserDefaults.standard.string(forKey: "email") ?? "irvanwilly9910@gmail.com"
        genderField.text = UserDefaults.standard.string(forKey: "gender") ?? "Male"
        birthdayField.text = UserDefaults.standard.string(forKey: "birthday") ?? "13 June 1997"
        phoneNumberField.text = UserDefaults.standard.string(forKey: "phoneNumber") ?? "081808370321"
    }
}
