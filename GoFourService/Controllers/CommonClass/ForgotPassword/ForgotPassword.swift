//
//  ForgotPassword.swift
//  GoFourService
//
//  Created by Dishant Rajput on 01/10/21.
//

import UIKit

class ForgotPassword: UIViewController {
    
    let paddingFromLeftIs:CGFloat = 10
    
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
                lblNavigationTitle.text = FORGOT_PASSWORD_NAVIGATION_TITLE
                lblNavigationTitle.textColor = NAVIGATION_TITLE_COLOR
                lblNavigationTitle.backgroundColor = .clear
            }
        }
                    
    // ***************************************************************** // nav
    
    @IBOutlet weak var lblText:UILabel!{
        didSet{
            lblText.text = """
                            Please enter your email address.
                            You will receive a link to create a new
                            password via email.
                            """
        }
    }
    
    @IBOutlet weak var txtEmailAddress:UITextField! {
        didSet {
            Utils.textFieldUI(textField: txtEmailAddress,
                              tfName: txtEmailAddress.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Email Address")
            
            
        }
    }
    
    @IBOutlet weak var btnResetPassword:UIButton! {
        didSet {
            Utils.buttonStyle(button: btnResetPassword, bCornerRadius: 4, bBackgroundColor: .black, bTitle: "RESET PASSWORD", bTitleColor: .white)
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
