//
//  UPDSReviewYourOrder.swift
//  GoFourService
//
//  Created by Apple on 04/03/21.
//

import UIKit

class UPDSReviewYourOrder: UIViewController {
    
    
    
    // ***************************************************************** // nav
                    
        @IBOutlet weak var navigationBar:UIView! {
            didSet {
                navigationBar.backgroundColor = NAVIGATION_COLOR
            }
        }
            
        @IBOutlet weak var btnBack:UIButton! {
            didSet {
                btnBack.tintColor = NAVIGATION_BACK_COLOR
            }
        }
            
        @IBOutlet weak var lblNavigationTitle:UILabel! {
            didSet {
                lblNavigationTitle.text = REVIEW_ORDER_NAVIGATION_TITLE
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
                    
    // ***************************************************************** // nav
    
    let cellReuseIdentifier = "uPDSReviewYourOrderTableCell"
    
    @IBOutlet weak var tbleView:UITableView! {
        didSet {
            tbleView.delegate = self
            tbleView.dataSource = self
        }
    }
    
    @IBOutlet weak var txtView:UITextView! {
        didSet {
            txtView.layer.cornerRadius = 8
            txtView.clipsToBounds = true
            txtView.layer.borderWidth = 0.6
            txtView.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    
    @IBOutlet weak var btnPlaceOrder:UIButton! {
        didSet {
            btnPlaceOrder.backgroundColor = NAVIGATION_COLOR
            btnPlaceOrder.addTarget(self, action: #selector(placeOrderClickMethod), for: .touchUpInside)
            btnPlaceOrder.setTitle("CONFIRM & PAY", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.tbleView.separatorColor = .clear
        
        self.btnBack.addTarget(self, action: #selector(backClickMethod), for: .touchUpInside)
        self.btnPlaceOrder.addTarget(self, action: #selector(placeOrderClickMethod), for: .touchUpInside)
        
        
        
    }
    
    @objc func backClickMethod() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- CONFIRM AND PAY -
    @objc func placeOrderClickMethod() {
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPDSFoodVerification")
        self.navigationController?.pushViewController(push, animated: true)
        
    }
    
    
    
    
    
    

}

//MARK:- TABLE VIEW -
extension UPDSReviewYourOrder: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UPDSReviewYourOrderTableCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UPDSReviewYourOrderTableCell
        
        cell.backgroundColor = .white
      
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

extension UPDSReviewYourOrder: UITableViewDelegate {
    
}
