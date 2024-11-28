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
        (NSLocalizedString("faq_order", comment: ""), NSLocalizedString("faq_order_answer", comment: ""), false),
        (NSLocalizedString("faq_change_order", comment: ""), NSLocalizedString("faq_change_order_answer", comment: ""), false),
        (NSLocalizedString("faq_payment_methods", comment: ""), NSLocalizedString("faq_payment_methods_answer", comment: ""), false),
        (NSLocalizedString("faq_track_order", comment: ""), NSLocalizedString("faq_track_order_answer", comment: ""), false),
        (NSLocalizedString("faq_delivery_or_pickup", comment: ""), NSLocalizedString("faq_delivery_or_pickup_answer", comment: ""), false),
        (NSLocalizedString("faq_cancel_order", comment: ""), NSLocalizedString("faq_cancel_order_answer", comment: ""), false),
        (NSLocalizedString("faq_discount_voucher", comment: ""), NSLocalizedString("faq_discount_voucher_answer", comment: ""), false),
        (NSLocalizedString("faq_missing_order", comment: ""), NSLocalizedString("faq_missing_order_answer", comment: ""), false),
        (NSLocalizedString("faq_loyalty_rewards", comment: ""), NSLocalizedString("faq_loyalty_rewards_answer", comment: ""), false),
        (NSLocalizedString("faq_modify_address", comment: ""), NSLocalizedString("faq_modify_address_answer", comment: ""), false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "HelpCenterTableViewCell", bundle: nil), forCellReuseIdentifier: "HelpCenterTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        toolBarView.setup(title: "Help Center")
    }
    
    @objc func toggleAnswerVisibility(sender: UIButton) {
        let index = sender.tag
        faqs[index].isExpanded.toggle()
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
}

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
        cell.configureCell(isExpanded: faq.isExpanded)
        
        cell.showHideButton.tag = indexPath.row
        cell.showHideButton.addTarget(self, action: #selector(toggleAnswerVisibility), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        faqs[indexPath.row].isExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
