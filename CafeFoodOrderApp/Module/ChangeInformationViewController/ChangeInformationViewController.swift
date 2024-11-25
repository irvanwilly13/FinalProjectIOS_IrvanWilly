//
//  ChangeInformationViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 04/11/24.
//

import UIKit

class ChangeInformationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var changeAvatarButton: UIButton!
    @IBOutlet weak var toolBarView: ToolBarView!
    
    @IBOutlet weak var nameField: CustomInputField!
    @IBOutlet weak var emailField: CustomInputField!
    @IBOutlet weak var genderField: CustomInputField!
    @IBOutlet weak var birthdayField: CustomInputField!
    @IBOutlet weak var phoneNumberField: CustomInputField!
    
    @IBOutlet weak var saveButton: UIButton!
    var profileData: DataProfileUser?
    
    
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
        
        emailField.isUserInteractionEnabled = false
        birthdayField.isUserInteractionEnabled = false
        
        // Optionally change their appearance to indicate they are disabled
        emailField.textColor = UIColor.gray
        birthdayField.textColor = UIColor.gray
    }
    
    func setup() {
        saveButton.addTarget(self, action: #selector(actionToSaveButton), for: .touchUpInside)
        changeAvatarButton.addTarget(self, action: #selector(changeAvatarButtonTapped), for: .touchUpInside)

    }
    @objc func changeAvatarButtonTapped() {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary // Pilih gambar dari galeri
            imagePicker.allowsEditing = true // Izinkan pengguna memotong gambar
            present(imagePicker, animated: true, completion: nil)
        }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: nil)
            
            if let editedImage = info[.editedImage] as? UIImage {
                imgView.image = editedImage // Set gambar yang dipilih ke imgView
            } else if let originalImage = info[.originalImage] as? UIImage {
                imgView.image = originalImage // Jika tidak ada edit, gunakan gambar asli
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    
    // Fungsi untuk menyimpan data terakhir yang diisi di textField
    @objc func actionToSaveButton() {
        // Menyimpan data ke UserDefaults
        UserDefaults.standard.set(nameField.text, forKey: "name")
        UserDefaults.standard.set(emailField.text, forKey: "email")
        UserDefaults.standard.set(genderField.text, forKey: "gender")
        UserDefaults.standard.set(birthdayField.text, forKey: "birthday")
        UserDefaults.standard.set(phoneNumberField.text, forKey: "phoneNumber")
        if let avatarImage = imgView.image, let imageData = avatarImage.pngData() {
                   UserDefaults.standard.set(imageData, forKey: "avatarImage")
               }
        
        // Menampilkan alert bahwa data berhasil disimpan
        let alert = UIAlertController(title: "Success", message: "Information saved successfully!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func loadSavedData() {
        // Gunakan nilai dari profileData atau nilai default
        nameField.text = profileData?.user.usFullname ?? UserDefaults.standard.string(forKey: "name") ?? "Irvan Willy"
        emailField.text = profileData?.user.usEmail ?? UserDefaults.standard.string(forKey: "email") ?? "irvanwilly9910@gmail.com"
        genderField.text = profileData?.prGender ?? UserDefaults.standard.string(forKey: "gender") ?? "Male"
        birthdayField.text = profileData?.prBirthdayDate ?? UserDefaults.standard.string(forKey: "birthday") ?? "13 June 1997"
        phoneNumberField.text = profileData?.user.usPhoneNumber ?? UserDefaults.standard.string(forKey: "phoneNumber") ?? "081808370321"
        if let imageData = UserDefaults.standard.data(forKey: "avatarImage"), let avatarImage = UIImage(data: imageData) {
                    imgView.image = avatarImage
                }
    }
    // Fungsi untuk memuat data yang tersimpan dan menampilkan di textField
    //    func loadSavedData() {
    //        nameField.text = UserDefaults.standard.string(forKey: "name") ?? "Irvan Willy"
    //        emailField.text = UserDefaults.standard.string(forKey: "email") ?? "irvanwilly9910@gmail.com"
    //        genderField.text = UserDefaults.standard.string(forKey: "gender") ?? "Male"
    //        birthdayField.text = UserDefaults.standard.string(forKey: "birthday") ?? "13 June 1997"
    //        phoneNumberField.text = UserDefaults.standard.string(forKey: "phoneNumber") ?? "081808370321"
    //    }
}
