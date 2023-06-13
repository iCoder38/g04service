//
//  success_ride_status.swift
//  GoFourService
//
//  Created by Dishant Rajput on 09/09/22.
//

import UIKit

class success_ride_status: UIViewController {

    @IBOutlet weak var btn_done:UIButton! {
        didSet {
            btn_done.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            btn_done.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            btn_done.layer.shadowOpacity = 1.0
            btn_done.layer.shadowRadius = 15.0
            btn_done.layer.masksToBounds = false
            btn_done.layer.cornerRadius = 6
            btn_done.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var lbl_payment_status:UILabel! {
        didSet {
            lbl_payment_status.textColor = .black
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            if person["role"] as! String == "Member" {
                
                self.lbl_payment_status.text = "Your payment has been completed. You can check your full booking details from Order history section."
                
            } else {
                
                self.lbl_payment_status.text = "Payment has been done and your booking has been completed."
                
            }
            
        }
        
        self.btn_done.addTarget(self, action: #selector(done_2_click_method), for: .touchUpInside)
    }
    
    @objc func done_2_click_method() {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            if person["role"] as! String == "Member" {
                
                
                
                 // CUSTOMER
                 let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPDSDashboardId")
                 self.navigationController?.pushViewController(push, animated: true)
               
            } else {
                
                // self.lbl_payment_status.text = "Your booking has been completed."
                
                // DRIVER
                let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DPDashboardId")
                self.navigationController?.pushViewController(push, animated: true)
  
            }
            
        }
        
        
        
    }

}
