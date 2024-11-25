//
//  HelpCenterViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 06/11/24.
//

import UIKit

class HelpCenterViewController: UIViewController {
    
    @IBOutlet weak var toolBarView: ToolBarView!
    @IBOutlet weak var tableView: UITableView!
    
    var faqs: [(question: String, answer: String, isExpanded: Bool)] = [
        ("How can I get New User Rewards?", "New user rewards are available for the first time...", false),
        ("Why don't I get the New User Rewards?", "The same phone number, the same mobile device...", false),
        ("How do I use my vouchers?", "Make sure your cart items meet all terms and...", false),
        ("Why did my voucher disappear?", "The mobile app will only show vouchers that...", false),
        ("What is TOMORO Points?", "TOMORO points are accumulated and calculated...", false),
        ("How to get TOMORO Points?", "Every time you present your membership code...", false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mendaftarkan sel kustom
        tableView.register(UINib(nibName: "HelpCenterTableViewCell", bundle: nil), forCellReuseIdentifier: "HelpCenterTableViewCell")
        
        // Mengatur delegate dan data source
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // Fungsi untuk mengubah visibilitas jawaban
    @objc func toggleAnswerVisibility(sender: UIButton) {
        let index = sender.tag
        faqs[index].isExpanded.toggle()
        
        // Reload row with animation
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
}

// MARK: - UITableViewDataSource
extension HelpCenterViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HelpCenterTableViewCell", for: indexPath) as? HelpCenterTableViewCell else {
            return UITableViewCell()
        }
        
        let faq = faqs[indexPath.row]
        cell.questionLabel.text = faq.question
        cell.answerLabel.text = faq.answer
        cell.configureCell(isExpanded: faq.isExpanded) // Konfigurasi animasi show/hide
        
        cell.showHideButton.tag = indexPath.row // Set tag untuk identifikasi
        cell.showHideButton.addTarget(self, action: #selector(toggleAnswerVisibility), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        faqs[indexPath.row].isExpanded.toggle() // Toggle expanded state
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
