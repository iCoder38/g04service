//
//  Disclaimer.swift
//  GoFourService
//
//  Created by Apple on 31/12/20.
//

import UIKit

class Disclaimer: UIViewController {

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
                lblNavigationTitle.text = DISCLAIMER_PAGE_NAVIGATION_TITLE
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
                    
    // ***************************************************************** // nav
    
    @IBOutlet weak var btnAcceptAndContinue:UIButton! {
        didSet {
            Utils.buttonStyle(button: btnAcceptAndContinue, bCornerRadius: 0, bBackgroundColor: NAVIGATION_COLOR, bTitle: "Accept & Continue", bTitleColor: .white)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.btnAcceptAndContinue.addTarget(self, action: #selector(acceptAndContinueClickMethod), for: .touchUpInside)
    }

    @objc func acceptAndContinueClickMethod() {
        let alert = UIAlertController(title: "Accept", message: "Are you sure you want to Accept and Continue ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes, Accept", style: .default, handler: { action in
            
            let settingsVCId = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginId") as? Login
            self.navigationController?.pushViewController(settingsVCId!, animated: true)
            
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: { action in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
