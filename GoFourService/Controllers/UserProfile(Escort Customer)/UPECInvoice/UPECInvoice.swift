//
//  UPECInvoice.swift
//  GoFourService
//
//  Created by Dishant Rajput on 23/10/21.
//

import UIKit

class UPECInvoice: UIViewController {
    
    
    
    // ***************************************************************** // nav
                    
        @IBOutlet weak var navigationBar:UIView! {
            didSet {
                navigationBar.backgroundColor = NAVIGATION_COLOR
            }
        }
            
        @IBOutlet weak var btnBack:UIButton! {
            didSet {
                btnBack.tintColor = NAVIGATION_BACK_COLOR
                btnBack.isHidden = true
            }
        }
            
        @IBOutlet weak var lblNavigationTitle:UILabel! {
            didSet {
                lblNavigationTitle.text = "Invoice"
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
                    
    // ***************************************************************** // nav
    
    @IBOutlet weak var btnPay:UIButton! {
        didSet {
            btnPay.backgroundColor = NAVIGATION_COLOR
            btnPay.addTarget(self, action: #selector(btnPayClickMethod), for: .touchUpInside)
            btnPay.setTitle("PAY NOW", for: .normal)
        }
    }
    @IBOutlet weak var lblAvgSpeed: UILabel!
    
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    
    @IBOutlet weak var lblTotalFare: UILabel!
    
    
    @IBOutlet weak var lblTotalDiscount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        
        
    }
    
    
    
    @objc func btnPayClickMethod(){
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPECSuccessRateDriver") as? UPECSuccessRateDriver
        self.navigationController?.pushViewController(push!, animated: true)
        
    }


}
