//
//  RegistrationTableCell.swift
//  GoFourService
//
//  Created by Apple on 31/12/20.
//

import UIKit

class RegistrationTableCell: UITableViewCell {

    let paddingFromLeftIs:CGFloat = 30
    
    @IBOutlet weak var viewBGForUpperImage:UIView! {
        didSet {
            viewBGForUpperImage.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var bgColor:UIImageView!
    
    @IBOutlet weak var btnSignIn:UIButton! {
        didSet {
            Utils.buttonStyle(button: btnSignIn, bCornerRadius: 0, bBackgroundColor: .clear, bTitle: "Sign In", bTitleColor: .white)
        }
    }
    
    @IBOutlet weak var btnSignUp:UIButton! {
        didSet {
            Utils.buttonStyle(button: btnSignUp, bCornerRadius: 0, bBackgroundColor: .clear, bTitle: "Sign Up", bTitleColor: .white)
        }
    }
    
    @IBOutlet weak var txtCustomerId:UITextField! {
        didSet {
            Utils.textFieldUI(textField: txtCustomerId,
                              tfName: txtCustomerId.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Customer Id")
        }
    }
    
    @IBOutlet weak var txtName:UITextField! {
        didSet {
            Utils.textFieldUI(textField: txtName,
                              tfName: txtName.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Name")
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
    
    @IBOutlet weak var txtPassword:UITextField! {
        didSet {
            Utils.textFieldUI(textField: txtPassword,
                              tfName: txtPassword.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Password")
        }
    }
    
    @IBOutlet weak var txtPhone:UITextField! {
        didSet {
            Utils.textFieldUI(textField: txtPhone,
                              tfName: txtPhone.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Phone Number")
        }
    }
    
    @IBOutlet weak var btnDOB:UIButton!
    @IBOutlet weak var txtDOB:UITextField! {
        didSet {
            Utils.textFieldUI(textField: txtDOB,
                              tfName: txtDOB.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "DOB")
        }
    }
    
    @IBOutlet weak var saveAndContinue:UIButton! {
        didSet {
            Utils.buttonStyle(button: saveAndContinue, bCornerRadius: 6, bBackgroundColor: .black, bTitle: "Save & Continue", bTitleColor: .white)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
