//
//  Success.swift
//  GoFourService
//
//  Created by Apple on 08/03/21.
//

import UIKit

class Success: UIViewController {

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
                lblNavigationTitle.text = SUCCESS_NAVIGATION_TITLE
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
                    
    // ***************************************************************** // nav
    
    @IBOutlet weak var btnTrackYourOrder:UIButton! {
        didSet {
            btnTrackYourOrder.backgroundColor = NAVIGATION_COLOR
            btnTrackYourOrder.layer.cornerRadius = 6
            btnTrackYourOrder.clipsToBounds = true
            btnTrackYourOrder.setTitle("Track your Order", for: .normal)
        }
    }
    
    @IBOutlet weak var btnHome:UIButton! {
        didSet {
            btnHome.backgroundColor = .systemGreen
            btnHome.layer.cornerRadius = 6
            btnHome.clipsToBounds = true
            btnHome.setTitle("Home", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.btnHome.addTarget(self, action: #selector(homeClickMethod), for: .touchUpInside)
        self.btnTrackYourOrder.addTarget(self, action: #selector(trackYourOrderClickMethod), for: .touchUpInside)
        
    }
    
    @objc func homeClickMethod() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPDSOrderFoodId")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func trackYourOrderClickMethod() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UPDSFoodOrderDetailsId")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
}
