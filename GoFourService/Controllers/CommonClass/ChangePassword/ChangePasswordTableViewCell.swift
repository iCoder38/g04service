//
//  ChangePasswordTableViewCell.swift
//  GoFourService
//
//  Created by Dishant Rajput on 01/10/21.
//

import UIKit

class ChangePasswordTableViewCell: UITableViewCell {
    
    let paddingFromLeftIs:CGFloat = 34
    
    @IBOutlet weak var txtCurrentPassword:UITextField! {
        didSet {
            Utils.textFieldUI(textField: txtCurrentPassword,
                              tfName: txtCurrentPassword.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Current Password")
        }
    }
    
    @IBOutlet weak var txtNewPassword:UITextField! {
        didSet {
            Utils.textFieldUI(textField: txtNewPassword,
                              tfName: txtNewPassword.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "New Password")
        }
    }
    
    @IBOutlet weak var txtConfirmPassword:UITextField! {
        didSet {
            Utils.textFieldUI(textField: txtConfirmPassword,
                              tfName: txtConfirmPassword.text!,
                              tfCornerRadius: 4,
                              tfpadding: paddingFromLeftIs,
                              tfBorderWidth: 0.8,
                              tfBorderColor: .darkGray,
                              tfAppearance: .dark,
                              tfKeyboardType: .default,
                              tfBackgroundColor: .white,
                              tfPlaceholderText: "Confirm Password")
        }
    }
    
    @IBOutlet weak var btnSignIn:UIButton! {
        didSet {
            Utils.buttonStyle(button: btnSignIn, bCornerRadius: 4, bBackgroundColor: .black, bTitle: "Update Password", bTitleColor: .white)
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
