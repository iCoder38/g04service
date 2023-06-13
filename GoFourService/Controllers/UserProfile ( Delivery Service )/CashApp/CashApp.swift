//
//  CashApp.swift
//  GoFourService
//
//  Created by Dishant Rajput on 19/10/21.
//

import UIKit

class CashApp: UIViewController {

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
                lblNavigationTitle.text = CASHAPP_NAVIGATION_TITLE
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
                    
    // ***************************************************************** // nav
    
    
    @IBOutlet weak var lblBillAmount: UILabel!{
        didSet{
            lblBillAmount.text = "$20.00"
        }
        
    }
    
    @IBOutlet weak var lblTime: UILabel!{
        didSet{
            lblTime.text = "Today at 08:42 PM"
        }
    }
    
    @IBOutlet weak var lblMultiLine: UILabel!{
        didSet{
            lblMultiLine.text =
 """
For You Won $500 Pay For
Verification CashAppSupport
"""
        }
    }
    @IBOutlet weak var btnPayment: UIButton!{
        
        didSet{
            btnPayment.layer.cornerRadius = 27.5
            btnPayment.clipsToBounds = true
            btnPayment.setTitle("Pay" + "$20.00", for: .normal)
            btnPayment.layer.borderWidth = 2.0
            btnPayment.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        btnBack.addTarget(self, action: #selector(btnBackPress), for: .touchUpInside)
    }
    
    @objc func btnBackPress(){
        self.navigationController?.popViewController(animated: true)
    }

}
