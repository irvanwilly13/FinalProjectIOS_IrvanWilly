//
//  BottomSheetReview.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 13/11/24.
//

import Foundation
import UIKit

class BottomSheetReview: UIViewController {
    
    @IBOutlet weak var coachMarkView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var textArea: UITextView!
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    
    private var rating: Int = 0 {
        didSet {
            updateStarRating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextArea()
        setupStarButtons()
        setup()
        
    }
    func setup() {
        submitButton.addTarget(self, action: #selector(submitReview), for: .touchUpInside)
        coachMarkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCoachMark)))
        
    }
    @objc func tapCoachMark() {
        UIView.animate(withDuration: 0.3) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // Fungsi untuk menyiapkan bintang
    private func setupStarButtons() {
        star1.addTarget(self, action: #selector(starTapped(_:)), for: .touchUpInside)
        star2.addTarget(self, action: #selector(starTapped(_:)), for: .touchUpInside)
        star3.addTarget(self, action: #selector(starTapped(_:)), for: .touchUpInside)
        star4.addTarget(self, action: #selector(starTapped(_:)), for: .touchUpInside)
        star5.addTarget(self, action: #selector(starTapped(_:)), for: .touchUpInside)
    }
    
    // Fungsi yang dipanggil saat bintang ditekan
    @objc private func starTapped(_ sender: UIButton) {
        switch sender {
        case star1:
            rating = 1
        case star2:
            rating = 2
        case star3:
            rating = 3
        case star4:
            rating = 4
        case star5:
            rating = 5
        default:
            break
        }
    }
    
    // Fungsi untuk memperbarui tampilan bintang berdasarkan rating
    private func updateStarRating() {
        let stars = [star1, star2, star3, star4, star5]
        for (index, star) in stars.enumerated() {
            let imageName = index < rating ? "star_filled" : "star_empty" // gunakan gambar sesuai (misalnya "star_filled" dan "star_empty")
            star?.setImage(UIImage(named: imageName), for: .normal)
        }
    }
    
    // Menyiapkan Text Area untuk ulasan
    private func setupTextArea() {
        textArea.layer.borderColor = UIColor.lightGray.cgColor
        textArea.layer.borderWidth = 1.0
        textArea.layer.cornerRadius = 8.0
        textArea.delegate = self
        textArea.text = "Write your review here..."
        textArea.textColor = UIColor.lightGray
    }
    @objc func submitReview() {
        guard rating > 0 else {
            print("Please select a star rating before submitting.")
            return
        }
        
        let reviewText = textArea.text == "Write your review here..." ? "" : textArea.text
        print("Submitted Review: Rating - \(rating), Review - \(reviewText ?? "")")
        
        // Menampilkan alert ucapan terima kasih
        let alert = UIAlertController(title: "Thank You!", message: "Thank you for submitting your review.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil) // Menutup bottom sheet setelah submit
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension BottomSheetReview: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Write your review here..." {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write your review here..."
            textView.textColor = UIColor.lightGray
        }
    }
}
